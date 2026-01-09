
if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
    . /usr/share/git-core/contrib/completion/git-prompt.sh
    export GIT_PS1_SHOWDIRTYSTATE=true
    export GIT_PS1_SHOWUNTRACKEDFILES=true
    export GIT_PS1_SHOWUPSTREAM="auto"
    export GIT_PS1_SHOWCOLORHINTS=true

    # \[e[32m\] = Start Green
    # \u@\h     = user@host
    # \[e[0m\]  = Reset color (so the rest is normal)
    # \W        = Current directory
    export PS1='[\[\e[32m\]\u@\h\[\e[0m\] \[\e[34m\]\W\[\e[0m\]$(__git_ps1 " (%s)")]\$ '
fi

alias "..=cd .."
