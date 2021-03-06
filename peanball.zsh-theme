#! /usr/bin/env zsh
local return_code="%(?..%{$fg_bold[red]%}%? %{↵%G%}%{$reset_color%})"

setopt promptsubst
# setopt PRINT_EXIT_VALUE

autoload -U add-zsh-hook

PROMPT_VENV_COLOR=$fg_no_bold[yellow]
PROMPT_PROMPT=$fg[default]
PROMPT_at=$fg_bold[yellow]
PROMPT_DATE_COLOR=$fg_no_bold[cyan]
PROMPT_TIME_COLOR=$fg_bold[cyan]

# Grab the current machine name 
MACHINE_="%{$fg_bold[blue]%}%m%{$reset_color%}"

# Grab the current username 
CURRENT_USER_="%{$fg[green]%}%n%{$reset_color%}"

PROMPT_DATE="%{${PROMPT_TIME_COLOR}%}%D{%H:%M} %{${PROMPT_DATE_COLOR}%}%D{%d/%m/%Y}%{$reset_color%}"

# declare -A clocks
# for h in $(echo $(seq 1 12)); do 
#     INDEX=${(l:2::0:)h}00; 
#     clocks[$INDEX]='\U'$(([##16]$((0x1F54F + $h)))); 
# done

# for h in $(echo $(seq 1 12)); do 
#     INDEX=${(l:2::0:)h}30; 
#     clocks[$INDEX]='\U'$(([##16]$((0x1F55B + $h)))); 
# done

# function clock_format() {
#     read -A TIME <<< $(date "+%I %M")

#     local hours=${TIME[1]}
#     # pad with '0' to 2 digits if needed
#     local minutes=${(l:2::0:)$(( ${TIME[2]}/30 * 30 ))}
    
#     echo "${clocks[$hours$minutes]}"
# }

RPS1="$return_code ${PROMPT_DATE}"
setopt transientrprompt

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_SEPARATOR="|"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_no_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[yellow]%}%{•%G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[red]%}%{✖%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[magenta]%}%{+%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{⇣%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{⇡%G%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{…%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}%{✔%G%}"

ZSH_THEME_GIT_PROMPT_CACHE=1

ZSH_THEME_VIRTUALENV_PREFIX=" ["
ZSH_THEME_VIRTUALENV_SUFFIX="]"

# User, Machine and Path
PROMPT='$CURRENT_USER_%{$FX[bold]$PROMPT_at%}@%{$reset_color%}$MACHINE_:%{$PROMPT_PROMPT%}%~%{$reset_color%}'

# Git Status
PROMPT+='$(git_super_status)'

# Virtual Environment
PROMPT+='%{$PROMPT_VENV_COLOR%}$(virtualenv_prompt_info)'

# Result dependent prompt color
PROMPT+='%2{%(?. %{$fg_bold[green]%}❯.%{$fg[red]%}•%{$fg_bold[red]%}❯)%}%{$reset_color%} ' 


