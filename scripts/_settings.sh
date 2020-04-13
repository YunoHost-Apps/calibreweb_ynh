#!/bin/bash

PKG_DEPENDENCIES="sqlite3 python3-pip imagemagick"
DOSSIER_MEDIA=/home/yunohost.multimedia
create_dir=0
LOG_FILE=/var/log/$app/$app.log
ACCESS_LOG_FILE=/var/log/$app/$app-access.log