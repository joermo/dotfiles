#!/bin/zsh


# Utility:
strip_colors() {
  output=$("$@" 2>&1 | sed -r 's/\x1B\[[0-9;]*m//g')
  echo "$output"
}

# Base template: https://github.com/dreamsofautonomy/zensh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load homebrew if installed
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi


if [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]] then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi


# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
# zinit snippet OMZP::archlinux
# zinit snippet OMZP::aws
# zinit snippet OMZP::kubectl
# zinit snippet OMZP::kubectx
# zinit snippet OMZP::command-not-found


# PATH:
if [[ $(command -v brew | wc -l) -eq 1 ]]; then
  eval "$(brew shellenv)"
fi
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
# bindkey '^n' history-search-backward
# bindkey '^p' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
[[ "$TERM" == "xterm-kitty" ]] && alias ssh="TERM=xterm-256color ssh"
alias v="$(command -v vim)"
alias ls='ls --color'
alias c='clear'
# alias zj='zellij'

vim() {
  arg_count="$#"
  if [[ arg_count -eq 0 ]]; then
    nvim
  elif [[ arg_count -eq 1 ]]; then
    file="$1"
    if [ -d "$file" ]; then
      cd "$file" && nvim "$file" && cd "--" || return
    else
      nvim "$file"
    fi
  else # more than 1 arg
    nvim "${@}"
  fi
}


# Helper function/alias to default to session called "main" and to enable fzf-based session selection when attaching
zj() {
  arg_1="${1:-null}"
  arg_count="$#"
  session_name="${2:-main}"
  if [[ arg_count -eq 0 ]]; then
    zellij attach --create "$session_name"
  elif [[ "$arg_1" = "attach" || "$arg_1" = "a" ]]; then
    if [[ arg_count -eq 1 ]];  then
      selection=$(zellij list-sessions | awk '{ print $1 }' | strip_colors | sort | fzf --height 30%)
      zellij attach "$selection"
    else
      zellij attach --create "$session_name"
    fi
  else
    zellij "$@"
  fi
}

alias kc='kubectl'
alias lg='lazygit'
export EDITOR='nvim'
export VISUAL='nvim'
if [[  $(command -v xclip | wc -l) -eq 1  ]]; then
  alias copy='xclip -selection clipboard'
  alias paste='xclip -selection clipboard -o'
fi
alias curbr='git branch --show-current'


# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"


# Python specifics:
export PYTHONDONTWRITEBYTECODE=1
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PATH="$HOME/.local/bin:$PATH" # Poetry path


lazy_load_node_npm() {
  unset -f node npm nvm
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

node() {
  lazy_load_node_npm && node "$@"
}
npm() {
  lazy_load_node_npm && node "$@"
}
nvm() {
  lazy_load_node_npm && node "$@"
}


export TERM=xterm-256color # for compatibility when SSH into remotes

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"; if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi
