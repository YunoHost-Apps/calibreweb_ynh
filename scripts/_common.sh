#!/bin/bash

pkg_dependencies="sqlite3"
create_dir=0

#=================================================
# EXPERIMENTAL HELPERS
#=================================================
#=================================================
# YUNOHOST MULTIMEDIA INTEGRATION
#=================================================

# Install or update the main directory yunohost.multimedia
#
# usage: ynh_multimedia_build_main_dir
ynh_multimedia_build_main_dir () {
        local ynh_media_release="v1.1"
#        local checksum="4852c8607db820ad51f348da0dcf0c88"

        # Download yunohost.multimedia scripts
        wget -nv https://github.com/Krakinou/yunohost.multimedia/archive/${ynh_media_release}.tar.gz 

        # Verify checksum
#        echo "${checksum} ${ynh_media_release}.tar.gz" | md5sum -c --status \
#                || ynh_die "Corrupt source"

        # Extract
        mkdir yunohost.multimedia-master
        tar -xf ${ynh_media_release}.tar.gz -C yunohost.multimedia-master --strip-components 1
        ./yunohost.multimedia-master/script/ynh_media_build.sh
}

# Grant write access to multimedia directories to a specified user
#
# usage: ynh_multimedia_addaccess user_name
#
# | arg: user_name - User to be granted write access
ynh_multimedia_addaccess () {
        local user_name=$1
        groupadd -f multimedia
        usermod -a -G multimedia $user_name
}