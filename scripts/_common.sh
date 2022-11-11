#!/bin/bash

PKG_DEPENDENCIES="sqlite3 imagemagick libldap2-dev libsasl2-dev python3-venv python3-dev python3-lxml libjpeg-dev zlib1g-dev libffi-dev"
#PKG_DEPENDENCIES="sqlite3 python3-pip imagemagick"

DOSSIER_MEDIA=/home/yunohost.multimedia

#These var are used in init_calibre_db_settings conf file
log_file=/var/log/$app/$app.log
access_log_file=/var/log/$app/$app-access.log


mach=`uname -m`

sha256_32bit=3365a848ce06d43fca8f1999eb69c6c8e0e20a56b6b8658a8466b9726adef0f5
sha256_64bit=37d7628d26c5c906f607f24b36f781f306075e7073a6fe7820a751bb60431fc5
sha256_arm=07f23275c4e674093443f01a591aa0980b0b87dbb0a10986d5001e9d56b0e1e7
sha256_arm64=5a15b8f6f6a96216c69330601bca29638cfee50f7bf48712795cff88ae2d03a3
sha256_armv6=7912901dc7b6f51e119f59cfd1f3f8ac2a5c64c42efba9d69ebf2ea8c3a7a2c9



case "$mach" in
 "armv6l" ) mach="arm"
			sha256=$sha256_arm 
			;;
 "armv7l" ) mach="arm"
			sha256=$sha256_arm 
			;;
 "armv8l" ) mach="arm64"
 			sha256=$sha256_arm64
 			;;
 "aarch64" ) mach="arm64"
 			sha256=$sha256_arm64
 			;;
 "x86_64" ) mach="64bit"
 			sha256=$sha256_64bit 
 			;;
 * ) mach="32bit" 
 	sha256=$sha256_32bit 
 	;;
esac
