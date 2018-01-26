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

echo "Installing desktop files, requires sudoer"
for f in .local/share/applications/*.desktop
do
  sudo desktop-file-install $f
done

echo "Done."
