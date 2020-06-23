#!/bin/bash

pkg_dependencies="sqlite3 libldap2-dev libsasl2-dev python3-dev imagemagick python3-lxml libjpeg-dev"
#PKG_DEPENDENCIES="sqlite3 python3-pip imagemagick"

python_version=3.5.9

DOSSIER_MEDIA=/home/yunohost.multimedia

LOG_FILE=/var/log/$app/$app.log
ACCESS_LOG_FILE=/var/log/$app/$app-access.log

#=================================================
# EXPERIMENTAL HELPERS
# TO BE DELETED WHEN RELEASED
#=================================================

version_gt() { 
	test "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1";
}

#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================
