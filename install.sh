#!/bin/bash
RED='\e[1;1;31m'
GREEN='\e[1;1;32m'
NC='\e[0m'

if [ $EUID -ne 0   ]; then
  echo -e "${RED}Not running as root${NC}"
  exit 2
fi

set -e

run_dir=$PWD
cd $(dirname $0)

dpkg --add-architecture i386

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub \
  | apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' \
  | tee /etc/apt/sources.list.d/google-chrome.list
apt update
apt upgrade -y
apt install gnome-core gdm3 -y
apt install linux-headers-$(uname -r) sudo rxvt-unicode -y
apt install build-essential cmake python-dev python3-dev python3-pip -y
apt install libc6:i386 -y
apt install ruby ruby-dev git -y
apt install google-chrome-stable task-print-server-y
apt install vlc gimp inkscape curl -y
curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
apt-get install -y nodejs
update-alternatives --set x-terminal-emulator /usr/bin/urxvt

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
