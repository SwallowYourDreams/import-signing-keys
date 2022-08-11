# import-signing-keys

Starting with Debian 11 and its derivatives (e.g. Ubuntu 22.04., Linux Mint 21), [`apt-key` is deprecated](https://www.linuxuprising.com/2021/01/apt-key-is-deprecated-how-to-add.html) and will be unavailable in future releases. Instead of placing signing keys in `/etc/apt/trusted.gpg` or `/etc/apt/trusted.gpg.d`, as `apt-key` does, users are encouraged to store them in `/usr/share/keyrings`. This script helps facilitate the process of migrating existing keys to the new place by...

* importing keys from a URL. For this, you can run the script using the `--url` flag.
* exporting existing keys from `apt-key`. For this, you can run the script using the `--export` flag.

After importing the keys, the script will also guide you through the process of linking the moved keyring to the PPA sources in `/etc/apt/sources.list.d.
