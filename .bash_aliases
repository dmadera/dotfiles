# enable color support of ls and also add handy aliases
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
alias pg='ping google.com'

# Clean DNS Cache
alias flushdns='dscacheutil -flushcache'

# Clear Cache
alias pigs='du | sort -nr | cut -f2- | xargs du -hs'
alias pigs1='du -d1 | sort -nr | cut -f2- | xargs du -hs'

alias server='open http://localhost:8000 && python -m SimpleHTTPServer'

alias o='xdg-open &>/dev/null'

