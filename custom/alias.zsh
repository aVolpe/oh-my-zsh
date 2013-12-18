#alias de directorios
alias go_d='cd /home/arturo/develop/facultad/workspace'
alias datos='cd /media/datos/'
alias tesis='/home/arturo/develop/tesis/documents/'


#Alais de programas SUDO
alias svi='sudo /usr/bin/vim'
alias ifconfig='sudo /sbin/ifconfig'

#Alias de facilidades
alias wget='wget -c'

#Alias mbaretes
alias kjboss='ruby /home/arturo/scripts/limpiar_standalone.rb'
alias tf='sh scripts/facu.sh'
alias sd='sudo /sbin/shutdown -t 00 now'
alias rb='sudo /sbin/reboot'
alias kc='ps -eF | grep chrome | tr -s " " | cut -d " " -f2 | xargs kill -9 && google-chrome'
alias open='kde-open '
alias grep='grep -i'
alias clip='xclip -selection clipboard'

#Alias de GIT
alias gc='git commit --verbose -s'
alias gd='git diff'
alias gp='git format-patch -1'
alias gpc="git format-patch -1 | xargs readlink -f | sed -e 's/^ *//g' -e 's/ *$//g' | xclip -selection clipboard"
alias gs='git status'
alias gpu='git pull && cd base && git pull && cd -'

#Alias de GRTK
alias te='python $PROGRAMS/grtk/spent.py'

alias trim="sed -e 's/^ *//g' -e 's/ *$//g'"
alias keys='less /home/arturo/scripts/shortcuts.txt'
alias clear_latex='find . -regex ".*\(aux\|bbl\|blg\|log\|nav\|out\|snm\|toc\)$" -exec rm -i {} \;'
mesg y



cat /home/arturo/.proxy_status
