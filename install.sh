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

cat > /etc/yum.repos.d/google-chrome.repo <<EOF
[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF

dnf upgrade --refresh -y
dnf install i3 i3status dmenu i3lock xbacklight feh conky -y
dnf install dnf-plugin-system-upgrade -y
dnf install google-chrome-stable gimp inkscape curl unzip -y
dnf install youtube-dl simple-scan -y
dnf install make automake gcc gcc-c++ kernel-devel -y
dnf install ruby ruby-devel rubygem-rake python-devel python3-devel -y

cp .bashrc ~/ -fv
cp .bash_aliases ~/ -fv
cp .Xdefaults ~/ -fv

su -c ./install-user-settings.sh madera.daniel

echo -e "${RED}Success. Please reboot your system.${NC}"
