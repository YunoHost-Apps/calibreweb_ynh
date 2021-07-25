
###Post install

Users having the calibreweb.main authorization group can be automatically sync from within the app, by using the "Import LDAP user" function.
Deletion of a Yunohost User will delete the according calibreweb-user.


###Library management

* **Library** will be placed in `/home/yunohost.multimedia/share/eBook` folder except if both :
 - calibreweb is set as a private application
 - calibreweb library is set as a public library

In this case the library will be set in `/home/yunohost.multimedia/[admin]/eBook` folder. Library folder can always be changed manually in the application settings by the administrator.

* By default, Yunohost backup process **will backup** Calibre library.
You may deactivate backup of the library with 
```
yunohost app setting calibreweb do_not_backup_data -v 1
```

* By default, removing the app will **never** delete the library.


* Authorization access to library to be done manually after install if Calibre library was already existing (except in yunohost.multimedia directory), for example :
```
chown -R calibreweb: path/to/library
or
chmod o+rw path/to/library
``` 

###OPDS

For **OPDS** to work, most OPDS-readers will require the app must be set in public mode.
Also, you may have to activate the "anonym browsing" for some reader to access book covers or download books ([source](https://github.com/janeczku/calibre-web/wiki/FAQ#which-opds-readers-work-with-calibre-web)).

###Versionning

Version number in Yunohost is different from the upstream Calibre-web app : version 0.X.Y becomes 0.9.X.Y in Yunohost. This is due to the fact that Calibre-web was not versionned when first packages were built.

### Known Limitations

* Do not use a Nextcloud folder. It's all right if the folder is an external storage in Nextcloud but not if it's an internal one : Changing the data in the library will cause trouble with the sync
* "Magic link feature is not yet available
* Change to library made outside calibreweb are not automatically updated in calibreweb. It is required to disconnect and reconnect to see the changes : Do not open a database both in calibre & calibreweb!
* Kobo Sync doesn’t work when Calibreweb is installed on a subdomain. This issue is caused by nginx. However, it works great when installed on a path e.g. `https://domain.tld/calibreweb`

## Todo
- [ ] Update mail settings with yunohost settings
- [ ] enable magic link
- [ ] Add cronjob to reload database (for nextcloud integration)
- [ ] Add config-panel option to trigger do_not_backup_data
- [ ] Add config-panel to manage max upload size
- [ ] Add action to restart the server
- [ ] Add action to synchronize users
- [ ] Add action to deactivate LDAP et retrieve admin password
- [ ] Use internal updater to update version?
