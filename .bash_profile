#
# ~/.bash_profile
#

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
fi

if [[ -f ~/.bashrc ]] && . ~/.bashrc
