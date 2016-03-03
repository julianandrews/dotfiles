dotfile_dir=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

function backup_and_link {
  backup_dir="$dotfile_dir/backup-$(date +%Y-%m-%d-%H%M)"
  source_file="$dotfile_dir/home/$1"
  target_file="$HOME/$1"
  mkdir -p $(dirname $target_file)
  if [ -L "$target_file" ]
  then
    # I should figure out how to properly backup a symlink
    unlink "$target_file"
  fi
  if [ -e "$target_file" ]
  then
    # This should be fixed to point to the correct relative path
    file_backup_dir="$backup_dir"
    mkdir -p "$file_backup_dir"
    mv "$target_file" "$file_backup_dir"
  fi
  ln -s "$source_file" "$target_file"
}

cd home
find . -type f | while read f; do
  backup_and_link "$f"
done
