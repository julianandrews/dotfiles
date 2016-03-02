dotfile_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

function backup_and_link {
  backup_dir="$dotfile_dir/backup_home"
  mkdir -p "$backup_dir"
  source_file="$dotfile_dir/home/$1"
  target_file="$HOME/$1"
  mkdir -p $(dirname $target_file)
  if [ -L "$target_file" ]; then unlink "$target_file"; fi
  if [ -e "$target_file" ]; then mv "$target_file" "$backup_dir"; fi
  ln -s "$source_file" "$target_file"
}

cd home
find . -type f | while read f; do
  backup_and_link "$f"
done
