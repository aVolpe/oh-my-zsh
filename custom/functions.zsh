# Para vimwiki
# Calcula el total de un archivo del tipo finanzas
total () {
    TO_G="#$1"
    HEADER='Archivo| Motivo| Dir| Monto| Tags|\n---------|---------|-----|---------|----------|'
    COINCIDENCES=`grep -R $TO_G | sort`
    WITH_HEADER="$HEADER \n$COINCIDENCES"
    echo "Calculando total de \e[5;1;31m\"$TO_G\"\e[0m. En total `grep -R $TO_G | wc -l` registros"
    echo "======================"
    echo $WITH_HEADER | column -s "|" -t 
    echo "======================"
    # Tiene el problema de no funcionar bien cuando se utilizan números en el motivo
    # grep -R $TO_G | sed -e 's/[0-9][0-9]\.//' -e 's/#.*//g' -e 's/\([^0-9]\)//g' | awk '{s+=$1} END {print "Total:\t\t\t\t\t\t" s}'

    # Al utilizar paste no formatea
    # grep -R mirti | sed -e 's/.*://g'  -e 's/.*\(-\|+\)/\1/g' -e 's/#.*//g' -e 's/\s//g' | paste -sd+ - | bc

    # Al utilizar el impresor de awk no permite la coloración
    #grep -R $TO_G | sed -e 's/.*://g'  -e 's/.*\(-\|+\)/\1/g' -e 's/#.*//g' -e 's/\s//g' | awk '{s+=$1} END {print "Total:\t\t\t\t\t\t" s}'
    # Formato Viejo
    #RESULT=`grep -R $TO_G | sed -e 's/.*://g'  -e 's/.*\(-\|+\)/\1/g' -e 's/#.*//g' -e 's/\s//g' | awk '{s+=$1} END {print s}'`
    RESULT=`grep -R $TO_G | sed -e '/.*=.*/d' -e '/.*--.*/d' -e '/^$/d' -e '/Fecha/d' -e 's/.*\(-\|+\)/\1/g' -e 's/|//' -e 's/|.*//g' -e 's/\s//g'  | awk '{s+=$1} END {print s}'`
    echo "Total:\t\t\t\t\t\t \e[1;31m$RESULT\e[0m"
}

# Para vimwiki
# Calcula el total de una cuenta (es decir, el saldo disponible)
total_cuenta () {
    FILE=$1
    REGISTER=`cat $FILE | sed -e 's/=.*//g' -e 's/.*\*Total\*.*//g' |  sed '/^$/d'`
    echo "Calculando estado de la cuenta \e[5;1;31m\"$FILE\"\e[0m. En total `echo $REGISTER | wc -l` movimientos "
    echo "======================"
    echo $REGISTER | column -s "|" -t | sed -e 's/^\s*//'
    echo "======================"
    RESULT=`echo $REGISTER |  sed -e '/.*=.*/d' -e '/.*--.*/d' -e '/^$/d' -e '/^Fecha/d' -e 's/.*\(-\|+\)/\1/g' -e 's/|//' -e 's/|.*//g' -e 's/\s//g' | awk '{s+=$1} END {print s}' `
    echo "Total:\t\t\t\t\t\t \e[1;31m$RESULT\e[0m"
}

# Suma lo que recibe como parámetro
calc () {
    bc -l <<< "$@"
}

# Modifica el brillo de la pantalla.
# Uso:
#    bright 0-10
# Parametros:
#    0-10: cantidad del brillo, donde 0=0% y 10=100%
bright () {
    sudo su -c "echo -n $1 > /sys/class/backlight/acpi_video0/brightness"
}

# Duplica un archivo, almacena una copia en el mismo lugar con la terminación "_"
# Uso:
#    duplicate /home/test/test
# Parametros:
#    /home/test/test: nombre del archivo a duplicar
# Resultado:
#    El archivo /home/test/test ahora tiene una copia denominada '/home/test/test_'
duplicate () {
    
    cp $1 "$1_"
    echo "$1_"
}
# Exactamente inverso a duplicate.
# Uso
#    revert_dup /home/test/test
# Parametros
#    Archivo a revertir, sin el "_" al final.
# Resultado
#    Archivo duplicado eliminado y la única copia esta en la ubicación original.
revert_dup () {
    
    mv "$1_" $1
    echo $1
}

create_month () {

    # Verifica si tiene lo minimo
    if [ -z "$1" ] || [ -z "$2" ] ;
    then
        echo "Utilización: \n\t create_month marzo number_days create_foler:false "
        return
    fi

    #Crea la carpeta
    if [ ! -z "$3" ]; 
    then
        echo "Creando directorio $1"
        mkdir $1
        echo "\n\n== $1 ==\n" >> gastos_diarios.wiki
    fi

    for i in {1..$2}
    do
        # El numbero del archivo
        NUMBER=$i
        if (( $i < 10 )); then
            NUMBER="0$i"
        fi
        # EL nombre sin extensión
        NAME="$1/$NUMBER"
        # Nombre completo
        NEW_FILE="$NAME.wiki"
        echo "Check $NEW_FILE"
        if [ ! -f $NEW_FILE ]
        then
            echo "Creando $NEW_FILE"
            cp template.wiki "$NEW_FILE"
            echo "* [[$NAME|$i]]" >> gastos_diarios.wiki
        fi
    done
}


down_video () { 
    TO_DOWNLOAD=$1;
    if [ -z "$1"];
    then
        TO_DOWNLOAD=`xclip -o`
    fi

    echo $TO_DOWNLOAD | sudo tee -a ~/videos/toDownload.txt
    echo "Agregando $TO_DOWNLOAD a la lista de descargas"

}

down_resume () {
   echo "Resumiendo descarga"
   cd ~/videos/
   sudo youtube-dl -c --batch-file=toDownload.txt  -o "%(title)s.%(ext)s"
}

down_clear() {

    sudo rm ~/videos/toDownload.txt
    sudo touch ~/videos/toDownload.txt
}


conv() {                                                                                                                                                           ✹master [Friday 06 June 11:05:09 AM]
    rm -f conv_tmp
    iconv --from-code=ISO-8859-1 --to-code=UTF-8 $1 -o conv_tmp 
    cat conv_tmp > $1
    rm conv_tmp
}
