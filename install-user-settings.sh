#!/bin/bash
GREEN='\e[1;1;32m'
NC='\e[0m'

set -e
run_dir=$PWD
cd $(dirname $0)

echo -e "${GREEN}Installing user's settings${NC}"

# installing dotfiles to home dir
cp .bashrc ~/ -fv
cp .bash_aliases ~/ -fv
cp .bash_logout ~/ -fv
cp .Xdefaults ~/ -fv
cp .config/user-dirs.* ~/.config/ -fv
cp .wallpapers ~/ -fvr

cd ~
if [[ ! -d ~/.vim/  ]]; then
  git clone https://github.com/daniel-madera/.vim.git
fi

~/.vim/update.sh

git config --global user.name "Daniel Maděra"
git config --global user.email "madera.dan@gmail.com"
git config --global core.editor vim
