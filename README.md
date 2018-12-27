
# Calibre-web for YunoHost

[![Install calibreweb with YunoHost](https://install-app.yunohost.org/install-with-yunohost.png)](https://install-app.yunohost.org/?app=calibreweb)

> *This package allow you to install calibreweb quickly and simply on a YunoHost server.  
If you don't have YunoHost, please see [here](https://yunohost.org/#/install) to know how to install and enjoy it.*

## Overview
This is an implementation of [Calibre-web](https://github.com/janeczku/calibre-web) for Yunohost.

Calibre-Web is a web app providing a clean interface for browsing, reading and downloading eBooks using an existing [Calibre](https://calibre-ebook.com) database.

*This software is a fork of [library](https://github.com/mutschler/calibreserver) and licensed under the GPL v3 License.*

Alternatively, you may use [COPS](https://github.com/YunoHost-Apps/cops_ynh) which also allows access to you Calibre Library, but in read-only mode. 

**Shipped version:** To be 1.0, let's say 0.9 :)

## Screenshots

![screenshot](https://raw.githubusercontent.com/janeczku/docker-calibre-web/master/screenshot.png)

## Backup library

By default, backup process will not backup Calibre library (backup_core_only logic).
You may activate backup of the library with 
```
yunohost app setting calibreweb backup_core_only -v 0
```
By default, removing the app will **never** delete the library.


## Limitations

* No LDAP support
* access to library to be done manually after install if Calibre library was already existing, for example :
```
chown -R calibreweb: path/to/library
or
chmod o+rw path/to/library
``` 
* Do not use a Nextcloud folder. It's all right if the folder is an external storage in Nextcloud but not if it's an internal one : Changing the data in the library will cause trouble with the sync
## Links

 * Report a bug: https://github.com/YunoHost-Apps/calibre_ynh/issues
 * App website: https://github.com/janeczku/calibre-web
 * YunoHost website: https://yunohost.org/

---

Developers info
----------------

Please do your pull request to the [testing branch](https://github.com/Krakinou/calibreweb_ynh/tree/Testing).

To try the testing branch, please proceed like that.
```
sudo yunohost app install https://github.com/Yunohost-Apps/calibre_ynh/tree/Testing --debug
or
sudo yunohost app upgrade calibreweb -u https://github.com/Yunohost-Apps/calibre_ynh/tree/Testing --debug
```


## Todo
- [ ] Multiinstance
- [ ] Better Multimedia integration : Integrate in Yunohost.multimedia
- [ ] Package_check integration
- [ ] On backup/remove/upgrade : check for database location to update settings


## LICENSE
Package and software are GPL 3.0
