#!/bin/bash

tmp_dir=$PWD

git config --global user.name "Daniel Maděra"
git config --global user.email "madera.dan@gmail.com"
git config --global core.editor vim

echo "Installing VIM config"
cd ~/
git clone git@github.com:daniel-madera/.vim.git
echo ":source /home/daniel/.vim/startup_remote.vim" > ~/.vimrc

cd $tmp_dir

echo "Renaming and removing home dirs"
if [ -d ~/Downloads  ] ; then
  rm ~/Downloads ~/Music ~/Templates ~/Public ~/Documents ~/Pictures ~/Videos -r
  mv ~/Desktop ~/desktop
fi

echo "Installing dotfiles to home dir"

cp .bashrc ~/ -fv
cp .bash_aliases ~/ -fv
cp .Xdefaults ~/ -fv

