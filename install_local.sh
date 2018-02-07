#!/bin/bash

if [ $EUID -ne 0  ]; then
  echo "Not running as root"
  exit 2
fi

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list

apt update
apt upgrade -y
apt install build-essential cmake python-dev python3-dev python3-pip -y
apt install ruby ruby-dev git -y
apt install vim vim-gtk vim-gnome google-chrome-stable git -y
apt install linux-headers-$(uname -r) sudo rxvt-unicode -y

usermod -a -G sudo daniel

su daniel ./install_user.sh

cp .bashrc ~/ -fv
cp .bash_aliases ~/ -fv
cp .Xdefaults ~/ -fv

for f in .local/share/applications/*.desktop
do
  desktop-file-install $f
done

echo "Done. Please reboot your system."
