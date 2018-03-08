#!/bin/bash
RED='\e[1;1;31m'
GREEN='\e[1;1;32m'
NC='\e[0m'

if [ $EUID -ne 0   ]; then
  echo -e "${RED}Not running as root${NC}"
  exit 2
fi

run_dir=$PWD
cd $(dirname $0)

apt purge evolution* gnome-chess gnome-contacts gnome-keyring gnome-maps \
  gnome-mines gnome-music gnome-robots gnome-sudoku gnome-weather -y

dpkg --add-architecture i386
apt update
apt upgrade -y
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub \
  | apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' \
  | tee /etc/apt/sources.list.d/google-chrome.list
apt install google-chrome-stable -y
apt install build-essential cmake python-dev python3-dev python3-pip -y
apt install libc6:i386 -y
apt install ruby ruby-dev git -y
apt install vim vim-gtk vim-gnome git -y
apt install linux-headers-$(uname -r) sudo rxvt-unicode -y
apt install vlc -y
update-alternatives --set x-terminal-emulator /usr/bin/urxvt

# load gnome settings
dconf load /org/gnome/ < dconf-gnome.dump

usermod -a -G sudo daniel

cp .bashrc ~/ -fv
cp .bash_aliases ~/ -fv
cp .Xdefaults ~/ -fv

su -c ./install-user-settings.sh daniel

for f in .local/share/applications/*.desktop
do
  desktop-file-install $f
done

echo -e "${RED}Success. Please reboot your system.${NC}"
