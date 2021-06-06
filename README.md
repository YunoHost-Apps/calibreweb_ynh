# Calibre-web for YunoHost

[![Integration level](https://dash.yunohost.org/integration/calibreweb.svg)](https://dash.yunohost.org/appci/app/calibreweb) ![](https://ci-apps.yunohost.org/ci/badges/calibreweb.status.svg) ![](https://ci-apps.yunohost.org/ci/badges/calibreweb.maintain.svg)  
[![Install calibreweb with YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=calibreweb)

> *This package allow you to install calibreweb quickly and simply on a YunoHost server.  
If you don't have YunoHost, please see [here](https://yunohost.org/#/install) to know how to install and enjoy it.*

## Overview
This is an implementation of [Calibre-web](https://github.com/janeczku/calibre-web) for Yunohost.

Calibre-Web is a web app providing a clean interface for browsing, reading and downloading eBooks using an existing [Calibre](https://calibre-ebook.com) database.

*This software is a fork of [library](https://github.com/mutschler/calibreserver) and licensed under the GPL v3 License.*

Alternatively, you may use [COPS](https://github.com/YunoHost-Apps/cops_ynh) which also allows access to your Calibre Library, but in read-only mode. 

**Shipped version:** The shipped version is 0.6.12 - Pilar, but as the numbering changed in the calibre-web app, it is numbered as 0.96.12 in yunohost.

Users will be synchronized with authorized Yunohost users (having the calibreweb.main authorization group) automatically. In case of issue you may force the sync in the app itself.

Library will be placed in `/home/yunohost.multimedia/share/eBook` folder except if both :
 - calibreweb is set as a private application
 - calibreweb library is set as a public library

In this case the library will be set in `/home/yunohost.multimedia/[admin]/eBook` folder. Library folder can always be changed manually in the application settings by the administrator.

## Screenshots

![screenshot](https://raw.githubusercontent.com/janeczku/docker-calibre-web/master/screenshot.png)

## Security
The default admin password of the app (admin123) is kept during the installation process. It is used as a fallback password in case of LDAP issue.
You should change it to something more secure in the app :)

## OPDS
For OPDS to work, most OPDS-readers will require the app must be set in public mode.
Also, you may have to activate the "anonym browsing" for some reader to access book covers or download books ([source](https://github.com/janeczku/calibre-web/wiki/FAQ#which-opds-readers-work-with-calibre-web)).

## Backup library

By default, Yunohost backup process **will backup** Calibre library.
You may deactivate backup of the library with 
```
yunohost app setting calibreweb do_not_backup_data -v 1
```

By default, removing the app will **never** delete the library.

## Known Limitations

* Authorization access to library to be done manually after install if Calibre library was already existing (except in yunohost.multimedia directory), for example :
```
chown -R calibreweb: path/to/library
or
chmod o+rw path/to/library
``` 
* Do not use a Nextcloud folder. It's all right if the folder is an external storage in Nextcloud but not if it's an internal one : Changing the data in the library will cause trouble with the sync
* "Magic link feature is not yet available
* Change to library made outside calibreweb are not automatically updated in calibreweb. It is required to disconnect and reconnect to see the changes : Do not open a database both in calibre & calibreweb!


## Links

 * Report a bug: https://github.com/YunoHost-Apps/calibreweb_ynh/issues
 * App website: https://github.com/janeczku/calibre-web
 * YunoHost website: https://yunohost.org/

---

## Developers info

Please do your pull request to the [testing branch](https://github.com/Yunohost-Apps/calibreweb_ynh/tree/testing).

To try the testing branch, please proceed like that.
```
sudo yunohost app install https://github.com/Yunohost-Apps/calibreweb_ynh/tree/testing --debug
or
sudo yunohost app upgrade calibreweb -u https://github.com/Yunohost-Apps/calibreweb_ynh/tree/testing --debug
```


## Todo
- [X] Multiinstance
- [X] Better Multimedia integration : Integrate in Yunohost.multimedia
- [X] rework LDAP integration to create user automatically
- [X] Package_check integration
- [X] On backup/remove/upgrade : check for database location to update settings
- [ ] Update mail settings with yunohost settings
- [ ] enable magic link
- [ ] Add cronjob to reload database (for nextcloud integration)
- [X] OPDS activation
- [ ] Add config-panel option to trigger do_not_backup_data
- [ ] Add config-panel to manage max upload size
- [ ] Add action to restart the server
- [ ] Add action to synchronize users
- [ ] Add action to deactivate LDAP et retrieve admin password
- [ ] Use internal updater to update version?



## LICENSE
Package and software are GPL 3.0
