
__prompt_status_line() {
    local EXIT="$?"
    local RED="\e[31m"
    local GREEN="\e[32m"
    local RESET="\e[0m"

    if [ $EXIT -eq 0 ]; then
        echo -ne "${GREEN}\$${RESET}"
    else
        echo -ne "${RED}${EXIT} \$${RESET}"
    fi
}

if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
    . /usr/share/git-core/contrib/completion/git-prompt.sh
    export GIT_PS1_SHOWDIRTYSTATE=true
    export GIT_PS1_SHOWUNTRACKEDFILES=true
    export GIT_PS1_SHOWUPSTREAM="auto"
    export GIT_PS1_SHOWCOLORHINTS=true

    export PS1='[\[\e[32m\]\u@\h\[\e[0m\] \[\e[34m\]\w\[\e[0m\]$(__git_ps1 " (%s)")]\n\[$(__prompt_status_line)\] '
fi

alias "..=cd .."
