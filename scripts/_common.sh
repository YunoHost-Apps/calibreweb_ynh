#!/bin/bash

DOSSIER_MEDIA=/home/yunohost.multimedia
log_file=/var/log/$app/$app.log
access_log_file=/var/log/$app/$app-access.log
mach=`uname -m`

#data_dir provisionning cannot be used as it is located into yunohost.multimedia directory and we don't want it to be moved around in case of changes
#We should have used a standard yunohost.app folder with symlink to yunohost.multimedia but meeeh...
#So, we dynamically set $data_dir based on $calibre_dir app settings instead of using the standard provisioning, which make it behaves
# as a standard data directory in backup, restore, upgrade and remove script.
if [ -n "$calibre_dir" ]; then
	data_dir=$calibre_dir
fi

case "$mach" in
 "armv6l" ) mach="arm"
			;;
 "armv7l" ) mach="arm"
			;;
 "armv8l" ) mach="arm64"
 			;;
 "aarch64" ) mach="arm64"
 			;;
 "x86_64" ) mach="64bit"
 			;;
 * ) mach="32bit"
 			;;
esac


_ynh_patch_policy_xml() {
    # Update Imagick policy as per
    # https://github.com/janeczku/calibre-web/wiki/FAQ#what-to-do-if-cover-pictures-are-not-extracted-from-pdf-files

    if [[ $YNH_DEBIAN_VERSION == "bookworm" ]]; then
        local policy=/etc/ImageMagick-6/policy.xml
        local match='<policy domain="coder" rights="none" pattern="PDF" />'
        local replace='<policy domain="coder" rights="read" pattern="PDF" />'
    elif [[ $YNH_DEBIAN_VERSION == "trixie" ]]; then
        local policy=/etc/ImageMagick-7/policy.xml
        local match='<policy domain="coder" rights="none" pattern="*" />'
        local replace='<policy domain="coder" rights="read" pattern="*" />'
    fi

    ynh_replace --file="$policy" --match="$match" --replace="$replace"
}

_ynh_unpatch_policy_xml() {
    if [[ $YNH_DEBIAN_VERSION == "bookworm" ]]; then
        local policy=/etc/ImageMagick-6/policy.xml
        local match='<policy domain="coder" rights="none" pattern="PDF" />'
        local replace='<policy domain="coder" rights="read" pattern="PDF" />'
    elif [[ $YNH_DEBIAN_VERSION == "trixie" ]]; then
        local policy=/etc/ImageMagick-7/policy.xml
        local match='<policy domain="coder" rights="none" pattern="*" />'
        local replace='<policy domain="coder" rights="read" pattern="*" />'
    fi

    if [[ -f "$policy" ]]; then
        ynh_replace --file="$policy" --match="$replace" --replace="$match"
    fi
}
