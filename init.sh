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

is_symlink() {
  [[ ! -L "$1" ]]
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
    #echo "$source doesn't exist; skipping"
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
  if [[ "$df" == "nvim-handroll" ]]; then
    echo "YES------------------"
    backup_if_necessary "$HOME/.config/nvim"
    create_link "$(pwd)/$df" "$HOME/.config/nvim"
  else
    backup_if_necessary "$HOME/.config/$df"
    create_link "$(pwd)/$df" "$HOME/.config/$df"
  fi
done

echo "$(pwd)"
