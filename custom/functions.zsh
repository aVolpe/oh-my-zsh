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
        mkdir "2015/$1"
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
        NAME="2015/$1/$NUMBER"
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


conv() {
    rm -f conv_tmp
    iconv --from-code=ISO-8859-1 --to-code=UTF-8 $1 -o conv_tmp
    cat conv_tmp > $1
    rm conv_tmp
}

function edit() {
    echo "Buscando $1"
    list=`find -iname "$1"`
    size=`echo $list | wc -l `
    chars=`echo $list | wc -m `
    if [ $chars -eq "1" ]
    then
        echo "No encontrado";
        return 0;
    fi

    if [ $size -eq "1" ]
    then
        echo "Opening $list"
        vim $list;
        return 0;
    fi

    echo "Cantidad de archivos: $size, seleccione alguno:"
    echo "0: Salir"
    i="1";
    while read -r line;
    do
        echo "$i: $line"
        i=$(($i+1))
    done <<< "$list"

    echo ""
    echo "Ingrese un numero:"
    read number
    while [ $number -gt $size ]
    do
        echo "Numero muy grande, elija otro"
        read number
    done
    if [ $number -eq "0" ]
    then
        return 0;
    fi
    file=`echo $list | head -n $number | tail -1`
    vim $file
}

# https://github.com/junegunn/fzf/wiki/example
function fe() {
  local file
  file=$(fzf --query="$1" --select-1 --exit-0 --preview 'bat --color always {}')
  [ -n "$file" ] && nvim "$file"
}

function fo() {
  local file
  file=$(fzf --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && open "$file"
}

function fd() {
  local dir
  dir=$(find ${1:-*} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

function fbr() {
  local branches branch
  branches=$(git --no-pager branch -vv --sort=committerdate) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

function fco_preview() {
  local branches target
  branches=$(git --no-pager branch -vv --all --sort=committerdate --color=always) || return
  target=$(
    echo "$branches" |
    fzf --no-hscroll --no-multi -n 1 \
        --no-sort --tac \
        --ansi --preview="git log --color=always -150 '..{1}'") || return
  git checkout $(echo "$target" | awk '{print $1}' | sed "s/.* //" | sed "s/remotes\/origin\///")
}

function v_cut() {

    ffmpeg -i "$3" -ss "$1" -to "$2" -c copy "$4"
}

function v_cut_from() {

    ffmpeg -i "$2" -ss "$1" -c:v copy -c:a copy "$3"
}

function v_cut_to() {

    ffmpeg -i "$2" -to "$1" -c copy "$3"
}

# Custom CD
function cd()
{
    builtin cd "$@"
    pwd > ~/.last_dir
}

function lcd()
{
    if [[ -f ~/.last_dir ]] 
    then
        LCD_PATH=`cat ~/.last_dir`
        cd $LCD_PATH
    fi
}

docker_id()
{
     echo `sudo docker ps | grep "$@" | cut -d" " -f1`
}

docker_rm()
{
    id=`docker_id "$@"`
    echo `sudo docker rm "$id"`
}

# uso ft_dev_log fintech-platapp-new-dev-worker-2 sgb 
ft_dev_log()
{
    id=`ssh -t $1 "docker ps"  | grep $2 | tail -n1 | awk '{print $1}'`
    echo ".$id."
    if [[ "$id" == "" ]]
    then
        echo "Container $2 not found on machine $1"
        return
    fi
    ssh -t $1 "docker exec $id  tail -f /usr/local/tomcat/temp/spring.log -n ${3:-1000}" 
    terminal-notifier -title "ft_dev_log" -subtitle "Finished" -message "Connection to log $2 in $1 closed"
}


# uso ft_dev_jcard_log fintech-platapp-hom-cms restapi
ft_dev_jcard_log()
{
    id=`ssh -t $1 "docker ps"  | grep $2 | tail -n1 | awk '{print $1}'`
    echo ".$id."
    if [[ "$id" == "" ]]
    then
        echo "Container $2 not found on machine $1"
        return
    fi
    ssh -t $1 "docker exec $id  tail -f -n ${3:-1000} ./restapi/log/q2.log" 
    terminal-notifier -title "ft_dev_log" -subtitle "Finished" -message "Connection to log $2 in $1 closed"
}

update_ctags()
{
    truncate --size 0 ctags
    CTAGS=`brew --prefix`/bin/ctags
    find . -name \*.java -exec $CTAGS --append {} \;
}

npmf() 
{
    cat package.json  \
        | jq -r ".scripts | to_entries | .[] | [.key, .value] | @tsv" \
        | fzf -1 \
          --delimiter "\t" \
          --ansi --tac \
          --bind 'enter:become(npm run {1})'
}


dbf() 
{
    # Rows 
    rows=$(cat ~/.config/pgcli/config |\
        sed -n -e '/\[alias_dsn\]/,/\[data_formats\]/ p' |\
        sed -n -e '/^#/!p' |\
        sed -n -e '/^\[/!p')
    with_header="NAME = CONNECTION\n${rows}"
    # Picks db
    db_name=$(echo $with_header |\
        column -s'=' -t |\
        fzf -1 --header-lines=1 +s --query=$1)
    if [[ $db_name != '' ]]; then
        db_name="$(echo $db_name | gsed "s#\s.*##")"
        echo "Connecting to $db_name"
        pgcli -D "$db_name"
    fi
}

db_docker() 
{
    # Picks db
    db_name=$(docker-compose ls |\
        sed -n -e '/\[alias_dsn\]/,/\[data_formats\]/ p' |\
        sed -n -e '/^#/!p' |\
        sed -n -e '/^\[/!p' |\
        column -s'=' -t |\
        grep "$1" |\
        sort |\
        fzf -1)
    if [[ $db_name != '' ]]; then
        db_name="$(echo $db_name | gsed "s#\s.*##")"
        echo "Connecting to $db_name"
        pgcli -D "$db_name"
    fi
}

gbf() 
{
    git for-each-ref \
        --sort=committerdate refs/heads/ \
        --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) # %(color:red)%(objectname:short)%(color:reset) # %(contents:subject) # %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))' \
        --color=always \
        | fzf --delimiter "#" \
        -1 \
        --ansi --no-sort --tac \
        --preview 'git log --oneline --color=always {1}' \
        --bind 'enter:become(git checkout {1})'
}
