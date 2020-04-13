# Base
HISTSIZE=99999
HISTFILESIZE=999999
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history

EDITOR=nvim

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

source ~/.config/aliasesrc

# UI
PROMPT='%n in %~ -> '
PROMPT='%F{208}%n%f in %F{226}%~%f -> '

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
# bindkey '^e' edit-command-line
bindkey -M vicmd '^e' edit-command-line

# Path stuff
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

source ~/.zsh_plugins.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
