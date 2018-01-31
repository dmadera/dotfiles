#!/bin/bash

if [ $EUID -ne 0  ]; then
  echo "Not running as root"
  exit 2
fi

if [ ! -f /home/daniel/.ssh/id_rsa.pub ]; then
  echo "Generate ssh private/public key and add it to github.com profile"
  exit 2
fi

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list

apt update
apt upgrade
apt install build-essential cmake python-dev python3-dev python3-pip
apt install ruby ruby-dev git
apt install vim vim-gtk vim-gnome google-chrome-stable git

su daniel ./install_user.sh

for f in .local/share/applications/*.desktop
do
  desktop-file-install $f
done

echo "Done."
