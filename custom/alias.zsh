#alias de directorios

#Alais de programas SUDO
alias svi='sudo /usr/bin/vim'
alias ifconfig='sudo /sbin/ifconfig'

#Alias de facilidades
alias wget='wget -c'
alias ps='ps -eF'
alias psg='ps -eF | grep'

#Alias mbaretes
alias kjboss='ruby ~/scripts/limpiar_standalone.rb'
alias tf='sh scripts/facu.sh'
alias sd='sudo /sbin/shutdown -t 00 now'
alias rb='sudo /sbin/reboot'
alias kc='ps -eF | grep chrome | tr -s " " | cut -d " " -f2 | xargs kill -9 && google-chrome'
alias open='kde-open '
alias grep='grep -i'
alias clip='xargs echo -n | xclip -selection clipboard'

#Alias de GIT
alias gc='git commit --verbose'
alias gd='git diff'
alias gp='git format-patch -1'
alias gpc="git format-patch -1 | xargs readlink -f | xargs echo -n | xclip -selection clipboard"
alias gs='git status'
alias gpu='git pull && cd base && git pull && cd -'
alias gclear='git reset --hard origin/master'

#Alias de GRTK
alias te='python $PROGRAMS/grtk/spent.py'

#Alias pseudo-scripts
alias trim="sed -e 's/^\s*//g' -e 's/\s*$//g'"
alias keys='less ~/scripts/shortcuts.txt'
alias clear_latex='find . -regex ".*\(aux\|bbl\|blg\|log\|nav\|out\|snm\|toc\|-blx\.bib\|pdf\|fdb_latexmk\|run\.xml\|fls\)$" -exec rm -i {} \;'

alias vup='qdbus org.kde.kmix /kmix/KMixWindow/actions/increase_volume org.qtproject.Qt.QAction.trigger'
alias vdo='qdbus org.kde.kmix /kmix/KMixWindow/actions/decrease_volume org.qtproject.Qt.QAction.trigger'
alias vmu='qdbus org.kde.kmix /kmix/KMixWindow/actions/mute org.qtproject.Qt.QAction.trigger'


function cd() 
{
	builtin cd "$@"
	pwd > ~/.last_dir
}

alias ll='ls -l --group-directories-first -h'
alias la='ls -la --group-directories-first -h'

alias tmux='TERM=xterm-256color tmux'
