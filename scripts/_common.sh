#!/bin/bash

PKG_DEPENDENCIES="sqlite3 imagemagick libldap2-dev libsasl2-dev python3-venv python3-dev python3-lxml libjpeg-dev zlib1g-dev libffi-dev"
#PKG_DEPENDENCIES="sqlite3 python3-pip imagemagick"

DOSSIER_MEDIA=/home/yunohost.multimedia

#These var are used in init_calibre_db_settings conf file
log_file=/var/log/$app/$app.log
access_log_file=/var/log/$app/$app-access.log
