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
# dnf install i3 i3status dmenu i3lock xbacklight feh conky -y
# dnf install pavucontrol xrandr py3status -y
# dnf install dnf-plugin-system-upgrade brightnessctl -y
dnf install rxvt-unicode-256color-ml vim-enhanced -y
dnf install google-chrome-stable gimp inkscape curl xclip okular -y
dnf install youtube-dl simple-scan -y
dnf install cmake make automake gcc gcc-c++ kernel-devel -y
dnf install ruby ruby-devel rubygem-rake python-devel python3-devel -y
dnf install ftp pv p7zip unar unzip nodejs wireshark -y

if [ ! -d "/mnt/disk" ]; then
  mkdir /mnt/disk
fi

su -c ./install-user-settings.sh dmadera

echo -e "${RED}Success. Please reboot your system.${NC}"
