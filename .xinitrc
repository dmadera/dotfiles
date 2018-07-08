#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# touchpad tap to click
xinput set-prop 13 "Synaptics Tap Action" 0 0 0 0 1 2 3
# set keyboard layout cz querty
setxkbmap -model pc104 -layout cz -variant qwerty

exec i3
