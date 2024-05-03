#!/bin/bash

export PYTHONDONTWRITEBYTECODE=1
# Pyenv specifics:
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
# Poetry path
export PATH="$HOME/.local/bin:$PATH"


# Zellij
alias zj='zellij options --default-layout compact'

# Vim
alias nvim="$HOME/Documents/programs/nvim.appimage"
alias v='vim'

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"

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


