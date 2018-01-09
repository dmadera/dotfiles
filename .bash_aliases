alias terminal='rxvt-unicode'

if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

#  ls aliases
alias l='ls -G'
alias ll='ls -l -h'
alias la='ls -a'
alias lla='ls -a -l'
alias lm='ls -la | less'
alias ..='cd ..'
alias ...='cd .. ; cd ..'

alias cls='clear'

alias flushdns='dscacheutil -flushcache'
alias o='xdg-open &>/dev/null'
alias server='python -m SimpleHTTPServer && o http://localhost:8000'
