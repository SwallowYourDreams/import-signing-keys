#!/bin/bash
mode=""
echo "This script automates the import of OpenPGP repository signing keys for PPAs."
if [ "$1" == "" ] ; then
	echo "Do you wish to import a key from a URL? [y/n]"
	read input
	if [ "$input" == "n" ] ; then
		echo "Do you wish to import a key from /etc/apt/trusted.gpg? [y/n]"
		read input
		if [ "$input" == "n" ] ; then
			echo "Well, that's all I can do for you. Aborting script."
			exit 0
		else
			mode="--export"
		fi
	else
		mode="--url"
	fi
else
	mode="$1"
fi
echo "Please enter the name of the package/repository."
read name
case $mode in
	--url)
		echo "Please enter the URL to the signing key: "
		read keyurl
		wget -O- "$keyurl" | gpg --dearmor > "/usr/share/keyrings/$name-keyring.gpg"
		;;
	--export)
		echo "Please enter the key ID (last eight digits from 'sudo apt-key list'):"
		read id
		sudo apt-key export "$id" | sudo gpg --dearmour -o "/usr/share/keyrings/$name-keyring.gpg"
		;;
	*)
		echo "Invalid flag or parameter: $1."
		;;
esac
echo "To finalise the import, you'll need to edit '/etc/apt/sources.list.d/your-application.list' and add the attribute 'signed-by= /usr/share/keyrings/$name-keyring.gpg'"
echo "Do you wish to open '/etc/apt/sources.list.d' with superuser privileges? [y/n]"
read input
if [ "$input" == "y" ] ; then
	sudo xdg-open "/etc/apt/sources.list.d"
fi
