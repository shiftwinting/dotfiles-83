# ==================
# Base
# ==================
HISTSIZE=99999
HISTFILESIZE=999999
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history

# ==================
# UI
# ==================
PROMPT='%n in %~ -> '
PROMPT='%F{208}%n%f in %F{226}%~%f -> '

# ==================
# Path stuff
# ==================
export PATH="/usr/local/opt/openssl/bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Android Development
export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export ANDROID_HOME="$HOME/Library/Android/sdk"

# Flutter
export PATH="$PATH:$HOME/development/flutter/bin"

# ==================
# Aliases
# ==================

alias ls='lsd'

# Useful aliases
alias vim="nvim"
alias vi="nvim"

# Docker
alias dc="docker container"
alias dn="docker network"

# Config
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
