# Home
Home directory scripts

## URXVT terminal emulator
Install URXVT terminal emulator
```bash
sudo apt install rxvt-unicode
# update default terminal to urxvt
sudo update-alternatives --config x-terminal-emulator
```

## Install all dotfiles
```bash
git clone git@github.com:daniel-madera/dotfiles.git
cd dotfiles
chmod +x install.sh
./install.sh
```
