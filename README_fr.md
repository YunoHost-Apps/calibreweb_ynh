# Calibre-web pour YunoHost

[![Niveau d'intégration](https://dash.yunohost.org/integration/calibreweb.svg)](https://dash.yunohost.org/appci/app/calibreweb) ![](https://ci-apps.yunohost.org/ci/badges/calibreweb.status.svg) ![](https://ci-apps.yunohost.org/ci/badges/calibreweb.maintain.svg)  
[![Installer Calibre-web avec YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=calibreweb)

*[Read this readme in english.](./README.md)*
*[Lire ce readme en français.](./README_fr.md)*

> *Ce package vous permet d'installer Calibre-web rapidement et simplement sur un serveur YunoHost.
Si vous n'avez pas YunoHost, regardez [ici](https://yunohost.org/#/install) pour savoir comment l'installer et en profiter.*

## Vue d'ensemble

Explorer, lire et télécharger des eBooks à partir d'une base de données Calibre

**Version incluse :** 0.6.14



## Captures d'écran

![](./doc/screenshots/screenshot.png)

## Avertissements / informations importantes


### Post installation

Les utilisateurs appartenant au groupe d'autorisation calibreweb.main peuvent être synchronisé automatiquement depuis l'application en utilisant la fonction "Importer les utilisateurs LDAP".
Lorsque les utilisateurs sont supprimés dans Yunohost, ils sont également supprimés dans Calibreweb.


### Gestion de la bibliothèque

* La **bibliothèque** sera placée dans `/home/yunohost.multimedia/share/eBook` sauf si simultanément :
  - Calibreweb est paramétré comme une application privée
  - La bibliothèque Calibreweb est paramétrée comme une bilbiothèque privée

Dans ce cas, la bibliothèque sera placée dans `/home/yunohost.multimedia/[admin]/eBook`. Le répertoire de la bibliothèque peut ensuite être déplacé directement dans l'application par l'administrateur.

* Par défaut, le processus de backup de Yunohost **archivera** la bibliothèque Calibreweb.
Vous pouvez le désactiver avec cette commande:
```
yunohost app setting calibreweb do_not_backup_data -v 1
```

* Par défaut, supprimer l'application **ne supprimera jamais** la bibliothèque.


* Si la bibliothèque existait avant l'installation de Calibreweb, les accès à celle-ci doivent être géré manuellement (sauf pour celle dans yunohost.multimedia directory). Par exemple :
```
chown -R calibreweb: chemin/vers/bibliothèque
ou
chmod o+rw chemin/vers/bibliothèque
``` 

### OPDS

Pour que l'**OPDS** fonctionne, la plupart des lecteurs OPDS exigent que l'application soit en accès publique.
Egalement, il se peut que l'activation de l'accès anonyme soit nécessaire pour accéder aux bibliothèque ou télécharger les livres sur certains lecteurs : ([source](https://github.com/janeczku/calibre-web/wiki/FAQ#which-opds-readers-work-with-calibre-web)).

### Version

La numérotation est modifiée dans yunohost par rapport à Calibre-web: la version 0.X.Y devient 0.9X.Y dans yunohost. Cela provient du fait que Calibre-web n'était pas versionné lors des premiers packages.

### Problèmes connus

* Ne pas utiliser un répertoire Nextcloud pour y installer la bibliothèque: Cela fonctionnera s'il s'agit d'un stockage externe à Nextcloud, mais pas dans le cas d'un répertoire interne qui causerait des problèmes lors des synchronisations. 
* La fonction "Magic link" n'est pas disponible
* Les changements fait à la bibliothèque en dehors de Calibreweb ne sont pas automatiquement vu par Calibreweb : Il est nécessaire de se déconnecter puis reconnecter ou redémarrer le service pour que les modifications soient visibles : N'utilisez donc pas simultanément Calibre et Calibreweb sur la même bibliothèque!
* La synchronisation Kobo ne fonctionne pas quand Calibreweb est installée dans un sous-domaine. Ce problème est causé par nginx. Par contre, cela fonctionne très bien quand installé dans un répertoire, par exemple `https://domain.tld/calibreweb`

## Todo
- [ ] Mise à jour des réglages mails
- [ ] Activation de magic link
- [ ] Add cronjob to reload database (for nextcloud integration)
- [ ] Add config-panel option to trigger do_not_backup_data
- [ ] Add config-panel to manage max upload size
- [ ] Add action to restart the server
- [ ] Add action to synchronize users
- [ ] Add action to deactivate LDAP et retrieve admin password
- [ ] Use internal updater to update version?

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