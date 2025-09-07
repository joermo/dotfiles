#!/bin/bash

declare -a dotfiles=(
  ".ideavimrc"
  ".p10k.zsh"
  ".zshrc"
  # ".bashrc"
)

declare -a dotfile_dirs=(
  "nvim-handroll"
  "zellij"
  "kitty"
  "alacritty"
)

is_env_var_set() {
    local var_name="$1"
    if [[ -z "${!var_name+x}" ]]; then
        return 1
    fi
    return 0
}

is_symlink() {
  [[ -L "$1" ]]
}

exists() {
  [[ -e "$1" ]]
}

create_link() {
  source="$1"
  dest="$2"
  if exists "$dest"; then
    rm -rf $dest
  fi
  echo "linking $source -> $dest"
  ln -sf "$source" "$dest"
}

backup_if_necessary() {
  source="$1"
  if ! exists "$source"; then
    return 0
  fi
  if ! is_symlink "$source"; then
    dest="$source.bak"
    echo "backing up $source -> $dest"
    mv "$source" "$dest"
  fi
}

for df in "${dotfiles[@]}"; do
  backup_if_necessary "$HOME/$df"
  create_link "$(pwd)/$df" "$HOME/$df"
done

for df in "${dotfile_dirs[@]}"; do
  # Current daily driver neovim config is nvim-handroll
  if [[ "$df" == "nvim-handroll" ]]; then
    backup_if_necessary "$HOME/.config/nvim"
    create_link "$(pwd)/$df" "$HOME/.config/nvim"
  else
    backup_if_necessary "$HOME/.config/$df"
    create_link "$(pwd)/$df" "$HOME/.config/$df"
  fi
done

# If the current machine is running nixos, symlink the nix configs
is_env_var_set "NIX_USER_PROFILE_DIR" && {
  # Must run with elevated permissions on nixos
  sudo bash -c "$(declare -f is_symlink exists backup_if_necessary); backup_if_necessary /etc/nixos"
  sudo bash -c "$(declare -f exists create_link); create_link '$(pwd)/nixos' /etc/nixos"
}
