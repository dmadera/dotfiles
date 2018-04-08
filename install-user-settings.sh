#!/bin/bash
GREEN='\e[1;1;32m'
NC='\e[0m'

set -e
run_dir=$PWD
cd $(dirname $0)

echo -e "${GREEN}Installing user's settings${NC}"

# renaming and removing home dirs
if [ ! -d ~/downloads ] ; then
  rm ~/Documents ~/Pictures ~/Videos -r
  mv ~/Desktop ~/desktop
  mv ~/Downloads ~/downloads
  mv ~/Music ~/media
  mv ~/Public ~/public
  mv ~/Templates ~/templates
fi

# load desktop settings
if [ -z "$DESKTOP_SESSION" ] ; then
  dconf load /org/$DESKTOP_SESSION/ < ./dconf/$DESKTOP_SESSION.dump
fi

# installing dotfiles to home dir
cp home/. ~/ -a

pip install --user pip
cd ~
if [[ ! -d ~/.vim/  ]]; then
  git clone https://github.com/daniel-madera/.vim.git
fi

~/.vim/update.sh

git config --global user.name "Daniel Maděra"
git config --global user.email "madera.dan@gmail.com"
git config --global core.editor vim
