# Path to your oh-my-zsh installation.
ZSH=~/.oh-my-zsh
plugins=(
  git
  history-substring-search
  vi-mode
  poetry
)

autoload -U compinit && compinit
autoload -U backward-kill-word-match
zle -N backward-kill-word-space backward-kill-word-match
zstyle ':zle:backward-kill-word-space' word-style space

bindkey -M viins '^K' history-substring-search-up
bindkey -M viins '^J' history-substring-search-down
bindkey '^R' fzf-history-widget
bindkey '^B' backward-kill-word-space
bindkey '^G' backward-kill-word

__fzf_history__() (
  local line
  shopt -u nocaseglob nocasematch
  line=$(
    HISTTIMEFORMAT= history | sort -k 2 | uniq -f 1 |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS --tac -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS +m" $(__fzfcmd) |
    command grep '^ *[0-9]') &&
    if [[ $- =~ H ]]; then
      sed 's/^ *\([0-9]*\)\** .*/!\1/' <<< "$line"
    else
      sed 's/^ *\([0-9]*\)\** *//' <<< "$line"
    fi
)
# Appends every command to the history file once it is executed
setopt inc_append_history
# Reloads the history whenever you use it
setopt share_history

export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"
# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL="en_US.UTF-8"
export EDITOR="nvim"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

# gpg agent configuration
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

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

# starship prompt: https://starship.rs/
eval "$(starship init zsh)"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
