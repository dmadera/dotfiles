echo "Installing dotfiles to home dir"

cp .bashrc ~/ -fv
cp .bash_aliases ~/ -fv
cp .bash_logout ~/ -fv
cp .Xdefaults ~/ -fv

echo "Installing desktop files, requires sudoer"
for f in .local/share/applications/*.desktop
do
  sudo desktop-file-install $f
done

echo "Done."
