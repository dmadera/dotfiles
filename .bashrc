# ~/.bashrc: executed by bash(1) for non-login shells.
[[ $- != *i* ]] && return

# autocomplete for sudo commands
complete -cf sudo

# check terminal size on regaining control (focus)
shopt -s checkwinsize

# history
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# colors
reset=$(tput sgr0)
bold=$(tput bold)
black=$(tput setaf 0)
green=$(tput setaf 2)
blue=$(tput setaf 4)
yellow=$(tput setaf 3)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
white=$(tput setaf 7)
# user head
export PS1="\[$reset\]\[$cyan\][\A] \[$green\]\u@\h\[$reset\]:\[$blue\]\w\[$reset\]\n\[$magenta\]>\[$reset\] "
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Tab Completions
set completion-ignore-case On
set show-all-if-ambiguous On

# export paths
export CDPATH=.:/run/user/1000/gvfs/
export PATH=$PATH:~/.local/bin/:/usr/local/cuda/bin/

source ~/.bash_aliases
