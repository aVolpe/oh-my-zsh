PROGRAMS='$HOME/programs'

#Alias de programas
alias liquibase="$PROGRAMS/programs/liquibase/liquibase"
alias jmeter="nohup  sh $PROGRAMS/develop/facultad/test/jmeter/bin/jmeter.sh &"
alias soapui="nohup sh $PROGRAMS/SoapUI-4.6.3/bin/soapui.sh"
alias ireport="sh $PROGRAMS/iReport-4.8.0/bin/ireport --jdkhome /usr/lib64/jvm/jre-1.7.0-openjdk/"

alias meld="open -W -a Meld --args "

alias jk-fielco=" java -jar $PROGRAMS/jenkins-fielco.jar  -s http://192.168.30.73:9090 " 
alias jk-cds="    java -jar $PROGRAMS/jenkins-fielco.jar  -s http://jenkins.cds.com.py " 
alias jk-bancard="java -jar $PROGRAMS/jenkins-bancard.jar -s http://10.100.19.152:8080 " 

alias ftp="/usr/local/opt/inetutils/libexec/gnubin/ftp"

#alias pngpaste='~/programs/pngpaste/pngpaste'
alias matterhorn="cd ~ && EDITOR='nvim -c \"set ft=markdown\" -c \"set spell\"' ~/programs/matterhorn-50200.18.0-Darwin-x86_64/matterhorn -c ~/.config/matterhorn/config.ini"
