#!/bin/bash
GREEN='\e[1;1;32m'
NC='\e[0m'

set -e
run_dir=$PWD
cd $(dirname $0)

echo -e "${GREEN}Installing user's settings${NC}"

# creating home dirs
if [ ! -d ~/downloads ] ; then
  mkdir ~/downloads
fi
if [ ! -d ~/desktop ] ; then
  mkdir ~/desktop
fi
if [ ! -d ~/media ] ; then
  mkdir ~/media
fi
if [ ! -d ~/public ] ; then
  mkdir ~/public
fi
if [ ! -d ~/templates ] ; then
  mkdir ~/templates
fi
if [ ! -d ~/.config ] ; then
  mkdir ~/.config
fi
if [ ! -d ~/.config/i3 ] ; then
  mkdir ~/.config/i3
fi

# installing dotfiles to home dir
cp .bashrc ~/ -fv
cp .bash_aliases ~/ -fv
cp .bash_logout ~/ -fv
cp .Xdefaults ~/ -fv
cp .config/user-dirs.* ~/.config/ -fv
cp .config/i3/config ~/.config/i3/config -fv

cd ~
if [[ ! -d ~/.vim/  ]]; then
  git clone https://github.com/daniel-madera/.vim.git
fi

~/.vim/update.sh

git config --global user.name "Daniel Maděra"
git config --global user.email "madera.dan@gmail.com"
git config --global core.editor vim
