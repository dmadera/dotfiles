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

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
cat > /etc/apt/sources.list.d/google-chrome.list <<EOF
deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main
EOF

apt update
apt install rxvt-unicode-256color -y
apt install vim vim-gtk vim-youcompleteme vim-snippets vim-command-t -y
apt install vim-autopep8 -y
apt install google-chrome-stable gimp inkscape xclip okular -y
apt install youtube-dl simple-scan pv -y
apt install cmake make automake gcc -y
apt install nodejs wireshark-qt ffmpeg -y
apt upgrade
apt dist-upgrade

if [ ! -d "/mnt/disk" ]; then
  mkdir /mnt/disk
fi

su -c ./install-user-settings.sh dmadera

echo -e "${RED}Success. Please reboot your system.${NC}"
