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

Calibre-web can sync your library and reading progress with Kobo e-readers and with apps that speak the Kobo sync protocol.

**1. Enable it (admin)**
In *Admin → Edit Basic Configuration → Feature Configuration*, tick *Enable Kobo sync* and set *Server External Port* to `443`. *Proxy unknown requests to Kobo Store* is only needed for real Kobo devices that should still reach the Kobo Store.

**2. Create a sync token (each user)**
Open your profile (click your username, top right) → *Kobo Sync Token* → *Create/View*. This gives a personal URL like `https://<your-domain>/kobo/<token>`.
Treat this URL like a password: anyone who has it can access your library.

**3. Connect the device or app**
- *Kobo e-reader:* put the URL as `api_endpoint` in `.kobo/Kobo/Kobo eReader.conf` on the device.
- In other apps: paste the full URL into the app's Kobo sync setting.
Use the same URL on every device you want to keep in sync.

By default the whole library is synced. To limit this, enable *Sync only books in selected shelves with Kobo* in your profile and mark the shelves to sync.

**Permissions**
A dedicated permission "Kobo sync" (`/kobo`) is created by default and is open to visitors, so sync clients can connect without going through the YunoHost SSO.
The token in the URL is what protects it. You don't need to expose the whole app.

**Warning:** Kobo devices are not compatible with hardened NGINX ciphers. Do not activate the "modern" policy. If you do, Kobo devices fail to connect with no
explanation other than "Internet not available".

**Kepub conversion**
Kepubify is set up as the default kepub converter during installation. When the sync token is created for the first time, your whole library is converted to kepub (existing epubs are not affected). This can take a long time: around 3–4 hours for ~10K books on a Raspberry Pi 4.

### OPDS

For **OPDS** to work, most OPDS-readers will require the app must be set in public mode.
Also, you may have to activate the "anonym browsing" for some reader to access book covers or download books ([source](https://github.com/janeczku/calibre-web/wiki/FAQ#which-opds-readers-work-with-calibre-web)).

### Versionning

Version number in Yunohost is different from the upstream Calibre-web app : version 0.X.Y becomes 0.9.X.Y in Yunohost. This is due to the fact that Calibre-web was not versionned when first packages were built.

### Known Limitations

* Do not use a Nextcloud folder. It's all right if the folder is an external storage in Nextcloud but not if it's an internal one : Changing the data in the library will cause trouble with the sync
* Change to library made outside Calibreweb are not automatically updated in Calibreweb. It is required to disconnect and reconnect to see the changes : Do not open a database both in Calibre & Calibreweb!
