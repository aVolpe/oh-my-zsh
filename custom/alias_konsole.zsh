function runwithprofile(){

    DEFAULT_SCHEME=`grep ColorScheme ~/.kde4/share/apps/konsole/Shell.profile | cut -d = -f2`
    if [[ -z "$TMUX" ]]
    then
        konsoleprofile colors="$1"
    else
        printf '\033Ptmux;\033\033]50;%s\007\033\\' colors="$1"
    fi
    if [[ -n "$3" ]]; then
        sudo $2
    else
        $2
    fi
    if [[ -z "$TMUX" ]]
    then
        konsoleprofile colors="$DEFAULT_SCHEME"
    else
        printf '\033Ptmux;\033\033]50;%s\007\033\\' colors="$DEFAULT_SCHEME"
    fi
}

alias cmus='runwithprofile "Harper" "cmus"'
alias yast='runwithprofile "Neopolitan" "/sbin/yast" su'
alias hangups='runwithprofile "3024 Night" "hangups"'
