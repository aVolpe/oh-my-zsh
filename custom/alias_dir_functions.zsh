ALIAS_DIR_FILE=~/.oh-my-zsh/custom/alias_dir.zsh

function adddir() {

    if [ -z "$1" ] ;
    then
      echo "Uso: adddir NOMBRE"
      return
    fi


    NAME=$1;
    DIR=`pwd | sed "s/\/home\/avolpe/\~/"`;

    echo "$NAME=$DIR" >> "$ALIAS_DIR_FILE"
    echo Agregando "$NAME=$DIR"
}

function deldir() {

    DIR=`pwd | sed "s/\/home\/avolpe/\~/"`
    echo Borrando linea `grep $DIR "$ALIAS_DIR_FILE"`
    grep -v $DIR "$ALIAS_DIR_FILE" >> /tmp/temp_dir_file
    mv /tmp/temp_dir_file "$ALIAS_DIR_FILE"
}

