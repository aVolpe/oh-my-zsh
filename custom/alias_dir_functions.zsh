ALIAS_DIR_FILE=~/.oh-my-zsh/custom/alias_dir.zsh

function adddir() {

    if [ -z "$1" ] ;
    then
        echo "Usage: adddir NOMBRE"
        return
    fi

    NAME=$1;
    DIR=`pwd | sed "s#$HOME#~#"`; # Removes the home from the path with a '~'

    echo "$NAME=$DIR" >> "$ALIAS_DIR_FILE"
    echo Added "$NAME=$DIR"
}

function deldir() {

    DIR=`pwd | sed "s#$HOME#~#"` # get the current file with a prefix of ~ instaed of the home
    echo Removing line `grep $DIR "$ALIAS_DIR_FILE"`
    grep -v $DIR "$ALIAS_DIR_FILE" >> /tmp/temp_dir_file
    mv /tmp/temp_dir_file "$ALIAS_DIR_FILE"
}


function cdf() {

    # Picks file
    dest_dir=$(cat $ALIAS_DIR_FILE |\
        gsed "s#$HOME#~#g" |\
        column -s'=' -t |\
        grep "$1" |\
        sort |\
        fzf -1)
    if [[ $dest_dir != '' ]]; then
        dest_dir="$(echo $dest_dir | gsed "s#~#$HOME#")"
        cd "$(echo $dest_dir | gsed 's/\w*\s\+//')"
    fi
}

function gbf() {
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

