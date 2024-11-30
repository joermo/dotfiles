is_symlink() {
  [[ ! -L "$1" ]]
}

exists() {
  [[ -e "$1" ]]
}

create_link() {
  source="$(pwd)/$1"
  dest="$HOME/.config/$1"
  if exists "$dest"; then
    rm -rf $dest
  fi
  echo "linking $source -> $dest"
  ln -s "$source" "$dest"
}

backup_if_necessary() {
  source="$1"
  if ! exists "$source"; then
    echo "$source doesn't exist; skipping"
    return 0
  fi
  if ! is_symlink "$source"; then
    dest="$source.bak"
    echo "backing up $source -> $dest"
    mv "$source" "$dest"
  fi
}

declare -a dotfile_dirs=(
  "nvim"
  "zellij"
  "kitty"
  "alacritty"
  ".ideavimrc"
  ".p10k.zsh"
  ".zshrc"
  # ".bashrc"
)

for conf in "${dotfile_dirs[@]}"; do
  backup_if_necessary "$conf"
  create_link "$conf"
done
