# Path to your oh-my-zsh installation.
ZSH=~/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(
  git
  history-substring-search
  vi-mode
)

bindkey -M viins '^K' history-substring-search-up
bindkey -M viins '^J' history-substring-search-down
bindkey '^R' fzf-history-widget

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"
# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL="en_US.UTF-8"
export EDITOR="nvim"

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

# gpg agent configuration
GPG_TTY=$(tty)
export GPG_TTY
if [ -z "$SSH_AUTH_SOCK" ]; then
    SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
    export SSH_AUTH_SOCK
fi

function hub-show () {
    hub pr list | fzf | awk '{print $1}' | tr -d \# | xargs -n1 hub pr show
}

function hub-co () {
    hub pr list | fzf | awk '{print $1}' | tr -d \# | xargs -n1 hub pr checkout
}

# custom functions
fpath=($HOME/.zshfunc "${fpath[@]}" )
autoload -Uz ikill icd

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases
source $HOME/.privaterc
source /usr/share/fzf/key-bindings.zsh
