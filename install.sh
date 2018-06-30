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

apt-get update
apt-get install rxvt-unicode-256color -y
apt-get install vim vim-gtk vim-youcompleteme vim-snippets vim-command-t -y
apt-get install vim-autopep8 -y
apt-get install google-chrome-stable gimp inkscape curl xclip okular -y
apt-get install youtube-dl simple-scan -y
apt-get install cmake make automake gcc gcc-c++ kernel-devel -y
apt-get install ruby ruby-devel rubygem-rake python-devel python3-devel -y
apt-get install ftp pv p7zip unar unzip nodejs wireshark ffmpeg -y
apt-get upgrade dist-upgrade

if [ ! -d "/mnt/disk" ]; then
  mkdir /mnt/disk
fi

su -c ./install-user-settings.sh dmadera

echo -e "${RED}Success. Please reboot your system.${NC}"
