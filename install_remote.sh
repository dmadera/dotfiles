#!/bin/bash

if [ $EUID -ne 0  ]; then
  echo "Not running as root"
  exit 2
fi

if [ ! -f /home/daniel/.ssh/id_rsa.pub ]; then
  echo "Generate ssh private/public key and add it to github.com profile"
  exit 2
fi

apt update
apt upgrade -y
apt install vim git -y
apt install linux-headers-$(uname -r) sudo -y

usermod -a -G sudo daniel

su daniel ./install_user_remote.sh

cp .bashrc ~/ -fv
cp .bash_aliases ~/ -fv

echo "Done. Please reboot your system."
