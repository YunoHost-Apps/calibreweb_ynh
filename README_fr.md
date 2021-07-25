# Calibre-web pour YunoHost

[![Niveau d'intégration](https://dash.yunohost.org/integration/calibreweb.svg)](https://dash.yunohost.org/appci/app/calibreweb) ![](https://ci-apps.yunohost.org/ci/badges/calibreweb.status.svg) ![](https://ci-apps.yunohost.org/ci/badges/calibreweb.maintain.svg)  
[![Installer Calibre-web avec YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=calibreweb)

*[Read this readme in english.](./README.md)*
*[Lire ce readme en français.](./README_fr.md)*

> *Ce package vous permet d'installer Calibre-web rapidement et simplement sur un serveur YunoHost.
Si vous n'avez pas YunoHost, regardez [ici](https://yunohost.org/#/install) pour savoir comment l'installer et en profiter.*

## Vue d'ensemble

Explorer, lire et télécharger des eBooks à partir d'une base de données Calibre

**Version incluse :** 0.96.12~ynh2



## Captures d'écran

![](./doc/screenshots/screenshot.png)

## Avertissements / informations importantes

* Any known limitations, constrains or stuff not working, such as (but not limited to):
**Shipped version:** The shipped version is 0.6.12 - Pilar, but as the numbering changed in the calibre-web app, it is numbered as 0.96.12 in yunohost.
Users will be synchronized with authorized Yunohost users (having the calibreweb.main authorization group) automatically. In case of issue you may force the sync in the app itself.

Library will be placed in `/home/yunohost.multimedia/share/eBook` folder except if both :
 - calibreweb is set as a private application
 - calibreweb library is set as a public library

In this case the library will be set in `/home/yunohost.multimedia/[admin]/eBook` folder. Library folder can always be changed manually in the application settings by the administrator.

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
* Kobo Sync doesn’t work when Calibre is installed on a subdomain. This issue is caused by nginx. However, it works great when installed on a path e.g. `https://domain.tld/calibreweb`

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
* Other infos that people should be aware of, such as:
    * any specific step to perform after installing (such as manually finishing the install, specific admin credentials, ...)
    * how to configure / administrate the application if it ain't obvious
    * upgrade process / specificities / things to be aware of ?
    * security considerations ?

## Documentations et ressources

* Documentation officielle de l'admin : https://github.com/janeczku/calibre-web/wiki
* Dépôt de code officiel de l'app : https://github.com/janeczku/calibre-web
* Documentation YunoHost pour cette app : https://yunohost.org/app_calibreweb
* Signaler un bug : https://github.com/YunoHost-Apps/calibreweb_ynh/issues

## Informations pour les développeurs

Merci de faire vos pull request sur la [branche testing](https://github.com/YunoHost-Apps/calibreweb_ynh/tree/testing).

Pour essayer la branche testing, procédez comme suit.
```
sudo yunohost app install https://github.com/YunoHost-Apps/calibreweb_ynh/tree/testing --debug
ou
sudo yunohost app upgrade calibreweb -u https://github.com/YunoHost-Apps/calibreweb_ynh/tree/testing --debug
```

**Plus d'infos sur le packaging d'applications :** https://yunohost.org/packaging_apps