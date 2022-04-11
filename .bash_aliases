alias terminal='rxvt-unicode'

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#  ls aliases
alias l='ls -G'
alias ll='ls -l -h'
alias la='ls -a'
alias lla='ls -a -l'
alias ..='cd ..'
alias ...='cd ..'

alias cpv="rsync -ah --progress"
alias vim='vim'

alias o='xdg-open &>/dev/null'
alias cclip='xclip -selection clipboard'

alias savana-ssh='ssh user@ssh.pemalbc.savana-hosting.cz -p 9108'
alias savana-sync-lipa='ssh user@ssh.pemalbc.savana-hosting.cz -p 9108 /www/velkoobchoddrogerie.cz/sync.sh'
alias savana-mount='sshfs user@ssh.pemalbc.savana-hosting.cz:/mnt/data/accounts/p/pemalbc/data/www /mnt/savana -C -p 9108'
alias savana-umount='umount /mnt/savana'
