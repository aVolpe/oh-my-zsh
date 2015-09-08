function runwithprofile(){

    DEFAULT_SCHEME=`grep ColorScheme ~/.kde4/share/apps/konsole/Shell.profile | cut -d = -f2`
    konsoleprofile colors="$1" 
    if [[ -n "$3" ]]; then
        sudo $2
    else
        $2
    fi
    konsoleprofile colors=$DEFAULT_SCHEME
}

alias cmus='runwithprofile "Harper" "cmus"'
alias yast='runwithprofile "Neopolitan" "/sbin/yast" su'
alias hangups='runwithprofile "3024 Night" "hangups"'
