
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
	eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
	eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
	(( count = $count + 1 ))
done
PR_NO_COLOUR="%{$reset_color%}"

local pwd='%{$fg[blue]%}%~%{$reset_color%}'
local date='$PR_LIGHT_GREEN%D{%a %d %b} $PR_CYAN%*$PR_YELLOW%D{%p}%f$PR_NO_COLOUR'
local git_branch='$(git_prompt_info)%{$reset_color%}'
#local return_code='%(?..%{$fg[red]%}%? ↵%{$reset_color%})'
#local git_branch='$(git_prompt_status)%{$reset_color%}$(git_prompt_info)%{$reset_color%}'

ZSH_THEME_RVM_PROMPT_OPTIONS="i v g"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"

PROMPT="${pwd} "
RPROMPT="${git_branch} [${date}]"
#ZSH_THEME_RUBY_PROMPT_PREFIX="%{$fg[green]%}‹"
#ZSH_THEME_RUBY_PROMPT_SUFFIX="›%{$reset_color%}"

#PROMPT="${user} ${pwd}$ "
#RPROMPT="${return_code} ${git_branch} \$(ruby_prompt_info)"
