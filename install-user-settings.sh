#!/bin/bash
RRED='\e[1;1;31m'
GREEN='\e[1;1;32m'
NC='\e[0m'

echo -e "${GREEN}Installing user's settings${NC}"

setxkbmap -layout cz -variant qwerty

# renaming and removing home dirs
if [ ! -d ~/downloads   ] ; then
  rm ~/Documents ~/Pictures ~/Videos -r
  mv ~/Desktop ~/desktop
  mv ~/Downloads ~/downloads
  mv ~/Music ~/media
  mv ~/Public ~/public
  mv ~/Templates ~/templates
fi

# installing dotfiles to home dir
cp .bashrc ~/ -fv
cp .bash_aliases ~/ -fv
cp .bash_logout ~/ -fv
cp .Xdefaults ~/ -fv
cp .config/user-dirs.* ~/.config/ -fv
cp .wallpapers ~/ -fvr

git config --global user.name "Daniel Maděra"
git config --global user.email "madera.dan@gmail.com"
git config --global core.editor vim

cd ~
# installing vim config
if [[ -d .vim/  ]]; then
  rm .vim/ -rf
fi

git clone --recursive https://github.com/daniel-madera/.vim.git

echo ":source /home/daniel/.vim/startup.vim" > ~/.vimrc

# set up VIM plugins
~/.vim/bundle/YouCompleteMe/install.py
pip3 install --user powerline-status
cd  ~/.vim/bundle/command-t
rake make

