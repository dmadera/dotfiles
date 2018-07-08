# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${chroot:-}" ] && [ -r /etc/chroot ]; then
  chroot=$(cat /etc/chroot)
fi

export TERM=xterm-256color

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${chroot:+($chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${chroot:+($chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
  xterm*|rxvt*)
    PS1="\[\e]0;${chroot:+($chroot)}\u@\h: \w\a\]$PS1"
    ;;
  *)
    ;;
esac

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

## Tab Completions
set completion-ignore-case On
set show-all-if-ambiguous On

extract() {
  clrstart="\033[1;34m"  #color codes
  clrend="\033[0m"

  if [[ "$#" -lt 1  ]]; then
    echo -e "${clrstart}Pass a filename. Optionally a destination folder. You can also append a v for verbose output.${clrend}"
    exit 1 #not enough args
  fi

  if [[ ! -e "$1"  ]]; then
    echo -e "${clrstart}File does not exist!${clrend}"
    exit 2 #file not found
  fi

  if [[ -z "$2"  ]]; then
    DESTDIR="." #set destdir to current dir
  elif [[ ! -d "$2"  ]]; then
    echo -e -n "${clrstart}Destination folder doesn't exist or isnt a directory. Create? (y/n): ${clrend}"
    read response
    #echo -e "\n"
    if [[ $response == y || $response == Y  ]]; then
      mkdir -p "$2"
      if [ $? -eq 0  ]; then
        DESTDIR="$2"
      else
        exit 6 #Write perms error
      fi
    else
      echo -e "${clrstart}Closing.${clrend}"; exit 3 # n/wrong response
    fi
  else
    DESTDIR="$2"
  fi

  if [[ ! -z "$3"  ]]; then
    if [[ "$3" != "v"  ]]; then
      echo -e "${clrstart}Wrong argument $3 !${clrend}"
      exit 4 #wrong arg 3
    fi
  fi

  filename=`basename "$1"`

  #echo "${filename##*.}" debug

  case "${filename##*.}" in
    tar)
      echo -e "${clrstart}Extracting $1 to $DESTDIR: (uncompressed tar)${clrend}"
      tar x${3}f "$1" -C "$DESTDIR"
      ;;
    gz)
      echo -e "${clrstart}Extracting $1 to $DESTDIR: (gip compressed tar)${clrend}"
      tar x${3}fz "$1" -C "$DESTDIR"
      ;;
    tgz)
      echo -e "${clrstart}Extracting $1 to $DESTDIR: (gip compressed tar)${clrend}"
      tar x${3}fz "$1" -C "$DESTDIR"
      ;;
    xz)
      echo -e "${clrstart}Extracting  $1 to $DESTDIR: (gip compressed tar)${clrend}"
      tar x${3}f -J "$1" -C "$DESTDIR"
      ;;
    bz2)
      echo -e "${clrstart}Extracting $1 to $DESTDIR: (bzip compressed tar)${clrend}"
      tar x${3}fj "$1" -C "$DESTDIR"
      ;;
    zip)
      echo -e "${clrstart}Extracting $1 to $DESTDIR: (zipp compressed file)${clrend}"
      unzip "$1" -d "$DESTDIR"
      ;;
    rar)
      echo -e "${clrstart}Extracting $1 to $DESTDIR: (rar compressed file)${clrend}"
      unar "$1" -o "$DESTDIR"
      ;;
    7z)
      echo -e  "${clrstart}Extracting $1 to $DESTDIR: (7zip compressed file)${clrend}"
      7za e "$1" -o"$DESTDIR"
      ;;
    *)
      echo -e "${clrstart}Unknown archieve format!"
      exit 5
      ;;
  esac
}

compress() {
  if [[ -n "$1"  ]]; then
    FILE=$1
    case $FILE in
      *.tar ) shift && tar cf $FILE $* ;;
      *.tar.bz2 ) shift && tar cjf $FILE $* ;;
      *.tar.gz ) shift && tar czf $FILE $* ;;
      *.tgz ) shift && tar czf $FILE $* ;;
      *.zip ) shift && zip $FILE $* ;;
      *.7z ) shift && 7za a $FILE $* ;;
    esac
  else
    echo "usage: compress <foo.tar.gz> ./foo ./bar"
  fi
}

git_clone() {
  if [[ -n "$1"  ]]; then
    git clone git@github.com:daniel-madera/$1.git
  else
    echo "usage: git_clone <repo_name>"
  fi
}

function cpv()
{
  local DST=${@: -1}                    # last element
  local SRC=( ${@: 1 : $# - 1} )        # array with rest of elements

  # checks
  type pv &>/dev/null || { echo "install pv first"; return 1; }
  [ $# -lt 2  ]       && { echo "too few args"    ; return 1; }

  # special invocation
  function cpv_rename()
  {
    local SRC="$1"
    local DST="$2"
    local DSTDIR="$( dirname "$DST" )"

    # checks
    if   [ $# -ne 2     ]; then echo "too few args"          ; return 1; fi
    if ! [ -e "$SRC"    ]; then echo "$SRC doesn't exist"    ; return 1; fi
    if   [ -d "$SRC"    ]; then echo "$SRC is a dir"         ; return 1; fi
    if ! [ -d "$DSTDIR" ]; then echo "$DSTDIR does not exist"; return 1; fi

    # actual copy
    echo -e "\n$SRC 🡺  $DST"
    pv   "$SRC" >"$DST"
  }

  # special case for cpv_rename()
  if ! [ -d "$DST" ]; then cpv_rename "$@"; return $?; fi;

    # more checks
    for src in "${SRC[@]}"; do
      local dst="$DST/$( basename "$src" )"
      if ! [ -e "$src" ]; then echo "$src doesn't exist" ; return 1;
      elif [ -e "$dst" ]; then echo "$dst already exists"; return 1; fi
    done

    # actual copy
    for src in "${SRC[@]}"; do
      if ! [ -d "$src" ]; then
        local dst="$DST/$( basename "$src" )"
        echo -e "\n$src 🡺  $dst"
        pv "$src" > "$dst"
      else
        local dir="$DST/$( basename "$src" )"
        mkdir "$dir" || continue
        local srcs=( $src/* )
        cpv "${srcs[@]}" "$dir";
      fi
    done
    unset cpv_rename
  }

  watchlog() {
    if [[ -f $1 ]]; then
      watch -n 1 -c tail -n 25 $1
    else
      echo "usage: watchlog <log_file>"
    fi
  }

  # enable programmable completion features (you don't need to enable
  # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
  # sources /etc/bash.bashrc).
  if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
      . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
    fi
  fi

  export CDPATH=.:/run/user/1000/gvfs/
  export PATH=$PATH:/usr/local/cuda/bin/
  export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages/:~/.local/lib/python2.7/site-packages/
