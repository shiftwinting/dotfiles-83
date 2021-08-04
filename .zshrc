# History
HISTSIZE=99999
HISTFILESIZE=999999
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history

HISTORY_IGNORE="(ls|cd|c|pwd|exit|cd ..)"

setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS

export VISUAL=nvim
export EDITOR=nvim

export MANPAGER='nvim +Man!'

# Basic auto/tab complete:
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

bindkey '^[[Z' reverse-menu-complete

bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward

# Ignore tab completion
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'

source ~/.config/aliasesrc
source ~/.zsh_plugins.sh

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Repeat last argument
bindkey '^O' insert-last-word

# end of line
bindkey '^E' end-of-line

# Vi stuff
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char
bindkey -M viins '^W' backward-delete-word

# Path stuff {{{
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="$HOME/own-scripts:$PATH"
export PATH="$PATH:$HOME/go/bin"

# Flutter
export PATH="$PATH:$HOME/flutter/bin"
export PATH="$PATH:$HOME/flutter/bin/cache/dart-sdk/bin"

# Python 3
export PATH="$HOME/Library/Python/3.7/bin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Android Development
export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export ANDROID_HOME="$HOME/Library/Android/sdk"

# }}}

# FZF {{{

export FZF_DEFAULT_OPTS="
    --layout=reverse
    --info=inline
    --multi
    --preview-window=:hidden
    --preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
    --color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'
    --prompt='∼ ' --pointer='▶' --marker='✓'
    --bind '?:toggle-preview'
    --bind 'ctrl-a:select-all'
    --bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
    --bind 'ctrl-e:execute(echo {+} | xargs -o nvim)'
    --bind 'alt-k:preview-up'
    --bind 'alt-j:preview-down'
    --bind 'alt-n:next-history'
    --bind 'alt-p:previous-history'
    --bind 'ctrl-n:down'
    --bind 'ctrl-p:up'
    "

# fzf's command
export FZF_DEFAULT_COMMAND="fd --hidden --follow --exclude '.git' --exclude 'node_modules'"

# CTRL-T's command
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# ALT-C's command
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"

_fzf_compgen_path() {
    fd . "$1"
}

_fzf_compgen_dir() {
    fd --type d . "$1"
}

# find-in-file - usage: fif <SEARCH_TERM>
fif() {
  if [ ! "$#" -gt 0 ]; then
    echo "Need a string to search for!";
    return 1;
  fi
  rg --files-with-matches --no-messages "$1" | fzf $FZF_PREVIEW_WINDOW --preview "rg --ignore-case --pretty --context 10 '$1' {}"
}

unalias z
z() {
  if [[ -z "$*" ]]; then
    cd "$(_z -l 2>&1 | fzf +s --tac | sed 's/^[0-9,.]* *//')"
  else
    _last_z_args="$@"
    _z "$@"
  fi
}

zz() {
  cd "$(_z -l 2>&1 | sed 's/^[0-9,.]* *//' | fzf -q "$_last_z_args")"
}

bip() {
    local inst=$(brew search | eval "fzf -m --header='[brew:install]'")

    if [[ $inst ]]; then
      for prog in $(echo $inst)
      do brew install $prog
      done
    fi
}

# }}}

# Forgit {{{

FORGIT_LOG_GRAPH_ENABLE=false

# }}}

# mktouch {{{
function mktouch {
  mkdir -p $( dirname $1 )
  touch $1
}
# }}}

# Git {{{

# Git checkout recent
gcr() {
  local branches branch preview
  preview="git log --oneline {} --color=always"
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
      fzf --preview="$preview" --preview-window=right:50% -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | delta'"

# fcoc_preview - checkout git commit with previews
fcoc_preview() {
  local commit
  commit=$( glNoGraph |
    fzf --no-sort --reverse --tiebreak=index --no-multi \
        --ansi --preview="$_viewGitLogLine" ) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow_preview - git commit browser with previews
fshow_preview() {
    glNoGraph |
        fzf --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview="$_viewGitLogLine" \
                --header "enter to view, alt-y to copy hash" \
                --bind "enter:execute:$_viewGitLogLine   | less -R" \
                --bind "alt-y:execute:$_gitLogLineToHash | xclip"
}

# }}}

# Utils {{{
alarmin() {
    seconds=$(( $2 * 60 ))
    osascript -e "(delay $seconds) & display notification \"$1\" with title \"Done!\" sound name \"beep\" & return" 2>/dev/null &
}
# }}}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# For test
export GOOGLE_APPLICATION_CREDENTIALS="/Users/aorrego/own-projects/go/credentials/pragmatic-reviews-8060a-firebase-adminsdk-2z1yp-575bc3194e.json"
