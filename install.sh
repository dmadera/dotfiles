#!/bin/bash

if [ $EUID -ne 0   ]; then
  echo "Not running as root"
  exit 2
fi

run_dir=$PWD
script_dir=$(cd "$(dirname "$0")" && pwd)
cd $script_dir

apt purge evolution* gnome-chess gnome-contacts gnome-keyring gnome-maps \
  gnome-mines gnome-music gnome-online-accounts gnome-online-miners \
  gnome-robots gnome-sudoku gnome-weather libreoffice* -y
apt clean -y
apt autoremove -y

apt update
apt upgrade -y
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub \
  | apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' \
  | tee /etc/apt/sources.list.d/google-chrome.list
apt install google-chrome-stable -y
apt install build-essential cmake python-dev python3-dev python3-pip -y
apt install ruby ruby-dev git -y
apt install vim vim-gtk vim-gnome git -y
apt install linux-headers-$(uname -r) sudo rxvt-unicode -y
apt install vlc -y
update-alternatives --set x-terminal-emulator /usr/bin/urxvt

usermod -a -G sudo daniel

cp .bashrc ~/ -fv
cp .bash_aliases ~/ -fv
cp .Xdefaults ~/ -fv

for f in .local/share/applications/*.desktop
do
  desktop-file-install $f
done

su daniel ./install-user-settings.sh

cd $run_dir

echo "Done. Please reboot your system."
