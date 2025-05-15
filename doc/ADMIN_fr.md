
### Gestion de la bibliothèque

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

### Synchronisation Kobo

Calibre-web possède [une fonction de synchronisation avec les liseuses Kobo](https://github.com/janeczku/calibre-web/wiki/Kobo-Integration). Vous pouvez activer cette fonctionnalité depuis le menu d'administration de l'application. Il faut paramétrer le port 443 comme port externe du serveur.
Une permission spécifique "Kobo sync" est créée lors de l'installation de l'application afin de ne pas avoir à exposer l'application entière.

[Kepubify](https://pgaskin.net/kepubify/) est également installé en tant que convertisseur par défaut vers le format kepub : Cela signifie que l'intégralité de votre bibliothèque sera convertie en format kepub lorsque vous créerez le jeton de synchronisation pour la première fois (ceci n'affecte pas les epubs existant). Cela peut prendre un certain temps : Par exemple, j'ai environ 10K livres dans ma bibliothèque calibre, et la conversion a durée environ 3-4h sur un Raspberry Pi 4 .

### OPDS

Pour que l'**OPDS** fonctionne, la plupart des lecteurs OPDS exigent que l'application soit en accès publique.
Egalement, il se peut que l'activation de l'accès anonyme soit nécessaire pour accéder aux bibliothèque ou télécharger les livres sur certains lecteurs : ([source](https://github.com/janeczku/calibre-web/wiki/FAQ#which-opds-readers-work-with-calibre-web)).

### Version

La numérotation est modifiée dans yunohost par rapport à Calibre-web: la version 0.X.Y devient 0.9X.Y dans yunohost. Cela provient du fait que Calibre-web n'était pas versionné lors des premiers packages.

### Problèmes connus

* Ne pas utiliser un répertoire Nextcloud pour y installer la bibliothèque: Cela fonctionnera s'il s'agit d'un stockage externe à Nextcloud, mais pas dans le cas d'un répertoire interne qui causerait des problèmes lors des synchronisations.
* Les changements fait à la bibliothèque en dehors de Calibreweb ne sont pas automatiquement vu par Calibreweb : Il est nécessaire de se déconnecter puis reconnecter ou redémarrer le service pour que les modifications soient visibles : N'utilisez donc pas simultanément Calibre et Calibreweb sur la même bibliothèque!
