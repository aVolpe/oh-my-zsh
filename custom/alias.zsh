#alias de directorios

#Alais de programas SUDO
alias svi='sudoedit'
alias systemctl='sudo systemctl'
alias ifconfig='sudo /sbin/ifconfig'

#Alias de facilidades
alias wget='wget -c'
alias ps='ps aux'
alias psg='/bin/ps aux | grep'

#Alias mbaretes
alias kjboss='ruby ~/scripts/limpiar_standalone.rb'
#alias tf='sh scripts/facu.sh'
#alias sd='sudo /sbin/shutdown -t 00 now'
#alias rb='sudo /sbin/reboot'
#alias kc='ps -eF | grep chrome | tr -s " " | cut -d " " -f2 | xargs kill -9 && google-chrome'
#alias open='kde-open '
alias grep='grep -i'
alias clip='xargs echo | xclip -selection clipboard'
alias clipn='xargs echo -n | xclip -selection clipboard'

#Alias de GIT
alias gc='git commit --verbose -s'
alias gd='git diff'
alias gp='git format-patch -1'
alias gpc="git format-patch -1 | xargs readlink -f | xargs echo -n | xclip -selection clipboard"
alias gs='git status'
alias gpu='git pull && cd base && git pull && cd -'
alias gclear='git reset --hard origin/master'
alias gcd='git checkout develop'
alias gbranches="git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"

#Alias de GRTK
#alias te='python $PROGRAMS/grtk/spent.py'

#Alias pseudo-scripts
alias trim="sed -e 's/^\s*//g' -e 's/\s*$//g'"
#alias keys='less ~/.scripts/shortcuts.txt'
#alias clear_latex='find . -regex ".*\(aux\|bbl\|blg\|log\|nav\|out\|snm\|toc\|-blx\.bib\|pdf\|fdb_latexmk\|run\.xml\|fls\)$" -exec rm -i {} \;'

#alias vup='qdbus org.kde.kmix /kmix/KMixWindow/actions/increase_volume org.qtproject.Qt.QAction.trigger'
#alias vdo='qdbus org.kde.kmix /kmix/KMixWindow/actions/decrease_volume org.qtproject.Qt.QAction.trigger'
#alias vmu='qdbus org.kde.kmix /kmix/KMixWindow/actions/mute org.qtproject.Qt.QAction.trigger'

alias ll='ls -l  -h'
alias la='ls -la  -h'

alias tmux='TERM=xterm-256color tmux'
alias agl='ag --pager "less -R" '
alias docker-kill='docker stop $(docker ps -aq)'

alias pngpaste='~/programs/pngpaste/pngpaste'
alias matterhorn="cd ~ && EDITOR='vim -c \"set ft=markdown\"' ~/programs/matterhorn-50200.5.0-Darwin-x86_64/matterhorn"
