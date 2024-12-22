# ~/.bashrc: executed by bash(1) for non-login shells.
[[ $- != *i* ]] && return

# turn off speaker beeping
#xset b off

# autocomplete for sudo commands
complete -cf sudo

# check terminal size on regaining control (focus)
#shopt -s checkwinsize

# history
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# colors
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White
export PS1="\[${Blue}\][\A] \[${Green}\]\u\[${Cyan}\]@\[${Green}\]\h:\[${Cyan}\]\w \n\[${BPurple}\]> \[${Color_Off}\]"
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Tab Completions
set completion-ignore-case On
set show-all-if-ambiguous On

#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# export paths
export CDPATH=.:/run/user/1000/gvfs/
export PATH=$PATH:~/.local/bin/:/usr/local/cuda/bin/

source ~/.bash_aliases
export PATH="$PATH:/opt/mssql-tools/bin"

export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS=' -p /usr/bin/python3 '
export PROJECT_HOME=$HOME/projects
source /usr/local/bin/virtualenvwrapper.sh
export PATH="$PATH:/opt/mssql-tools18/bin"
export PATH="$PATH:/opt/mssql-tools18/bin"
