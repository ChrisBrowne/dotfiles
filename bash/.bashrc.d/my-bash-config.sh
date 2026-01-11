
__prompt_status_line() {
    local EXIT="$?"
    local RED="\001\e[31m\002"
    local GREEN="\001\e[32m\002"
    local RESET="\001\e[0m\002"

    if [ $EXIT -eq 0 ]; then
        echo -ne " ${GREEN}${EXIT}${RESET}"
    else
        echo -ne " ${RED}${EXIT}${RESET}"
    fi
}

if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
    . /usr/share/git-core/contrib/completion/git-prompt.sh
    export GIT_PS1_SHOWDIRTYSTATE=true
    export GIT_PS1_SHOWUNTRACKEDFILES=true
    export GIT_PS1_SHOWUPSTREAM="auto"
    export GIT_PS1_SHOWCOLORHINTS=true

    export PS1='[\[\e[32m\]\u@\h\[\e[0m\] \[\e[34m\]\w\[\e[0m\]$(__git_ps1 " (%s)")]\[$(__prompt_status_line)\]\n\[\e[32m\]❯\[\e[m\] '
fi

alias "..=cd .."
alias "rdpphoton=xfreerdp /v:photon.brownehq /u:chris /d:. /network:auto /audio-mode:0 /gfx:avc444 /size:3840x2160 /scale:180 /dynamic-resolution"
alias "rdpandromeda=xfreerdp /v:andromeda.brownehq /u:localsvc /d:. /network:auto /audio-mode:0 /gfx:avc444 /size:3840x2160 /scale:180 /dynamic-resolution"
alias "wakephoton=sudo ether-wake E8:6A:64:57:E1:A5"
alias "wakeandromeda=sudo ether-wake 94:18:82:37:DB:15"

