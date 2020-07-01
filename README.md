# Dot files - home dir
> Setting file for linux home directory

## Installation

```sh
cd ~
git init
git remote add origin git@github.com:dmadera/dotfiles.git
git pull origin master
# solve conflicts
# rename dirs according to .config/user-dirs.dirs
dconf load /org/gnome/terminal/legacy/profiles:/ < .config/gnome-terminal-profiles.dconf
```

## Tips

```sh
# backup gnome-terminal settings
dconf dump /org/gnome/terminal/legacy/profiles:/ > .config/gnome-terminal-profiles.dconf
# all files/folder are ignored; each file has to be added
git add <file-path>
```
