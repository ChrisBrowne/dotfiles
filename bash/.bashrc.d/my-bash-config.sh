function moon() {
  REF_DATE="Jan 15 2023"
  REF_PERCENT=75
  SEC_PER_DAY=86400
  SYNODIC_SECONDS=2551443
  REF_EPOCH=`date --date "$REF_DATE" +%s`
  NOW_EPOCH=`date +%s`
  NOW_DISPLAY=`date "+%b %d %Y"`
  SEC_DIFF=$(($NOW_EPOCH - $REF_EPOCH))
  CENTI_MOONS=$((100 * $SEC_DIFF / $SYNODIC_SECONDS))
  MOON_PERCENT=$((($CENTI_MOONS + $REF_PERCENT) % 100))

  if [[ $MOON_PERCENT -lt 7 ]]; then
    echo "🌑"
  elif [[ $MOON_PERCENT -lt 19 ]]; then
    echo "🌒"
  elif [[ $MOON_PERCENT -lt 32 ]]; then
    echo "🌓"
  elif [[ $MOON_PERCENT -lt 44 ]]; then
    echo "🌔"
  elif [[ $MOON_PERCENT -lt 57 ]]; then
    echo "🌕"
  elif [[ $MOON_PERCENT -lt 69 ]]; then
    echo "🌖"
  elif [[ $MOON_PERCENT -lt 82 ]]; then
    echo "🌗"
  elif [[ $MOON_PERCENT -lt 94 ]]; then
    echo "🌘"
  else
    echo "🌑"
  fi
}
CURRENT_MOON_PHASE=$(moon)

if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
    . /usr/share/git-core/contrib/completion/git-prompt.sh
    export GIT_PS1_SHOWDIRTYSTATE=true
    export GIT_PS1_SHOWUNTRACKEDFILES=true
    export GIT_PS1_SHOWUPSTREAM="auto"
    export GIT_PS1_SHOWCOLORHINTS=true

    export PS1='[\[\e[32m\]\u@\h\[\e[0m\] \[\e[34m\]\w\[\e[0m\]$(__git_ps1 " (%s)")] $CURRENT_MOON_PHASE $(code=$?; if [ $code -ne 0 ]; then echo -e "\033[31m $code\033[0m "; fi) \n\[\e[32m\]❯\[\e[m\] '
fi

export YDOTOOL_SOCKET=/tmp/.ydotool_socket

# Increase history capacity (Standard is usually 1000)
export HISTSIZE=10000
export HISTFILESIZE=20000

# Don't log duplicate lines or lines starting with a space
export HISTCONTROL=ignoreboth

# Append to history immediately after each command (Instant History)
# and ensure multiple sessions don't overwrite each other
shopt -s histappend
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Set timestamp format (YYYY-MM-DD HH:MM:SS)
export HISTTIMEFORMAT="%F %T "

# Ignore common/unhelpful commands from history
export HISTIGNORE="history:exit"

alias "..=cd .."
alias "...=cd ../.."
alias "rdpphoton=xfreerdp /v:photon.brownehq /u:chris /d:. /network:auto /audio-mode:0 /gfx:avc444 /size:3840x2160 /scale:180 /dynamic-resolution"
alias "rdpandromeda=xfreerdp /v:andromeda.brownehq /u:localsvc /d:. /network:auto /audio-mode:0 /gfx:avc444 /size:3840x2160 /scale:180 /dynamic-resolution"
alias "wakephoton=sudo ether-wake E8:6A:64:57:E1:A5"
alias "wakeandromeda=sudo ether-wake 94:18:82:37:DB:15"
alias l='ls -lah'

alias gor='cd ~/dev/juxt/rorschach'
alias gom='cd ~/dev/juxt/meridian'

