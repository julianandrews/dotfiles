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

function build_command_t {
  cd "$dotfile_dir/.vim/bundle/command-t/ruby/command-t"
  ruby extconf.rb
  make
}

backup_and_link .config/i3
backup_and_link .config/i3status
backup_and_link .config/xfce4/terminal/terminalrc
backup_and_link .virtualenvs/postactivate
backup_and_link bin/earthporndesktop
backup_and_link bin/gmail-count
backup_and_link .bashrc
backup_and_link .vimrc
backup_and_link .vim

git submodule init
git submodule update

.vim/bundle/YouCompleteMe/install.sh --clang-completer
build_command_t
