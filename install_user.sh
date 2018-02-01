#!/bin/bash

tmp_dir=$PWD

git config --global user.name "Daniel Maděra"
git config --global user.email "madera.dan@gmail.com"
git config --global core.editor vim

echo "Installing VIM config"
cd ~/
git clone --recursive git@github.com:daniel-madera/.vim.git
echo ":source /home/daniel/.vim/startup.vim" > ~/.vimrc

# set up VIM plugins
~/.vim/bundle/YouCompleteMe/install.py
pip3 install --user powerline-status
cd  ~/.vim/bundle/command-t
rake make

cd $tmp_dir

echo "Renaming and removing home dirs"
if [ ! -d ~/downloads  ] ; then
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

