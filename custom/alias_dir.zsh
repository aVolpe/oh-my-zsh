function adddir() {

    if [ -z "$1" ] ;
    then
	    echo "Uso: adddir NOMBRE"
	    return
    fi

    
    NAME=$1;
    DIR=`pwd`;

    echo "$NAME=$DIR" >> ~/.oh-my-zsh/custom/alias_dir.zsh
}



TESIS=~/develop/tesis/documents/
DROPBOX=~/.dropbox/Dropbox/
WIKI=~/.dropbox/Dropbox/wiki/
FINANZAS=~/.dropbox/Dropbox/wiki/finanzas/
JBOSS=/home/avolpe/develop/servidores/jboss-as-7.1.1.Final
DEV=/home/avolpe/develop
LIBRO=/home/avolpe/.dropbox/Dropbox/sharelatex/libro/libro
CDS=/home/avolpe/develop/cds
CEAMSO=/home/avolpe/develop/ceamso
