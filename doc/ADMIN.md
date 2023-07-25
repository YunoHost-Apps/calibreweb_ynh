### Library management

* By default, Yunohost backup process **will backup** Calibreweb library.
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

### Kobo Sync

Calibre-web comes with a [synching feature with a kobo device](https://github.com/janeczku/calibre-web/wiki/Kobo-Integration). You can activate this feature from inside the app in the administration menu. You need to set port 443 as the external server port.
A dedicated permission "Kobo sync" is created by default by the app so that you don't need to expose the whole app for synching.

[Kepubify](https://pgaskin.net/kepubify/) is also set up as the default kepub converter during installation : This means that your whole library will be converted to kepub when creating the sync token for the first time (this will not affect the existing epubs). This can take a long time : For reference, I have around 10K ebooks on my calibre library and the conversion lasted around 3-4hours on a raspberry Pi 4.

### OPDS

For **OPDS** to work, most OPDS-readers will require the app must be set in public mode.
Also, you may have to activate the "anonym browsing" for some reader to access book covers or download books ([source](https://github.com/janeczku/calibre-web/wiki/FAQ#which-opds-readers-work-with-calibre-web)).

### Versionning

Version number in Yunohost is different from the upstream Calibre-web app : version 0.X.Y becomes 0.9.X.Y in Yunohost. This is due to the fact that Calibre-web was not versionned when first packages were built.

### Known Limitations

* Do not use a Nextcloud folder. It's all right if the folder is an external storage in Nextcloud but not if it's an internal one : Changing the data in the library will cause trouble with the sync
* Change to library made outside Calibreweb are not automatically updated in Calibreweb. It is required to disconnect and reconnect to see the changes : Do not open a database both in Calibre & Calibreweb!
* Kobo Sync doesn’t work when Calibreweb is installed on a subdomain. This issue is caused by nginx. However, it works great when installed on a path e.g. `https://domain.tld/calibreweb`
