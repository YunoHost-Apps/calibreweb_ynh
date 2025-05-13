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