#!/bin/bash

echo "Installing user's settings"

setxkbmap -layout cz -variant qwerty

echo "Renaming and removing home dirs"
if [ ! -d ~/downloads   ] ; then
  rm ~/Documents ~/Pictures ~/Videos -r
  mv ~/Desktop ~/desktop
  mv ~/Downloads ~/downloads
  mv ~/Music ~/media
  mv ~/Public ~/public
  mv ~/Templates ~/templates
fi

echo "Installing dotfiles to home dir"
cp .bashrc ~/ -fv
cp .bash_aliases ~/ -fv
cp .bash_logout ~/ -fv
cp .Xdefaults ~/ -fv
cp .config/user-dirs.* ~/.config/ -fv
cp .wallpapers ~/ -fvr

git config --global user.name "Daniel Maděra"
git config --global user.email "madera.dan@gmail.com"
git config --global core.editor vim

# load gnome settings
dconf load /org/gnome/ < dconf-gnome.dump

cd ~
echo "Installing VIM config"
if [[ ! -d .vim/  ]]; then
  git clone --recursive https://github.com/daniel-madera/.vim.git
else
  cd .vim/ && git pull origin master
fi
echo ":source /home/daniel/.vim/startup.vim" > ~/.vimrc

# set up VIM plugins
~/.vim/bundle/YouCompleteMe/install.py
pip3 install --user powerline-status
cd  ~/.vim/bundle/command-t
rake make

echo "Leaving..."
