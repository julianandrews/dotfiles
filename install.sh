dotfile_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

function backup_and_link {
  backup_dir="$dotfile_dir/backup"
  mkdir -p "$backup_dir"
  source_file="$dotfile_dir/$1"
  target_file="$HOME/$1"
  if [ -L "$target_file" ]; then unlink "$target_file"; fi
  if [ -e "$target_file" ]; then mv "$target_file" "$backup_dir"; fi
  ln -s "$source_file" "$target_file"
}

backup_and_link .config/i3
backup_and_link .config/i3status
backup_and_link .config/xfce4/terminal/terminalrc
backup_and_link .virtualenvs/postactivate
backup_and_link bin
backup_and_link .bashrc
backup_and_link .vimrc
backup_and_link .vim
