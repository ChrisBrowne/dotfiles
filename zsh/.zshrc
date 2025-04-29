function season() {
  DOY=$(date +%j)
  if [[ $DOY -lt 79 ]]; then
    echo "⛄"
  elif [[ $DOY -lt 172 ]]; then
    echo "🌱"
  elif [[ $DOY -lt 265 ]]; then
    echo "🌞"
  elif [[ $DOY -lt 356 ]]; then
    echo "🍂"
  else
    echo "⛄"
  fi
}

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

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH:/usr/local/go/bin

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"


# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
  git 
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

S=$(season)
M=$(moon)

export PS1=$PS1$' 🏡 $S $M \n$ '

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.cargo/env"
source /usr/share/doc/fzf/examples/key-bindings.zsh
