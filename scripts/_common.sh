#!/bin/bash

DOSSIER_MEDIA=/home/yunohost.multimedia
log_file=/var/log/$app/$app.log
access_log_file=/var/log/$app/$app-access.log
mach=`uname -m`

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