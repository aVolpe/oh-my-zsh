#alias de directorios
alias go_d='cd /home/arturo/develop/facultad/workspace'
alias datos='cd /media/datos/'
alias tesis='/home/arturo/develop/tesis/documents/5ta'


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

#Alias de GIT
alias gc='git commit --verbose -s'
alias gd='git diff'
alias gp='git format-patch -1'
alias gs='git status'
alias gpu='git pull && cd base && git pull && cd -'

#Alias de GRTK
alias te='python $PROGRAMS/grtk/spent.py'
