dotfile_dir=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

function backup_and_link {
  backup_dir="$dotfile_dir/backup-$(date +%Y-%m-%d_%H-%M-%S)"
  source_file="$1"
  rel_path=$(echo $1 | sed 's|'"$dotfile_dir/home"'/||')
  target_file="$HOME/$rel_path"
  file_backup_dir="$(dirname "$backup_dir/$rel_path")"
  if [ -L "$target_file" ]
  then
    real_file="$(readlink -f "$target_file")"
    if [ "$real_file" != "$source_file" ]
    then
      mkdir -p "$file_backup_dir"
      ln -s "$real_file" "$file_backup_dir/$(basename "$target_file")"
    fi
    unlink "$target_file"
  fi
  if [ -e "$target_file" ]
  then
    mkdir -p "$file_backup_dir"
    mv "$target_file" "$file_backup_dir/"
  fi
  mkdir -p $(dirname $target_file)
  ln -s "$source_file" "$target_file"
}

find "$dotfile_dir/home" -type f | while read f; do
  backup_and_link "$f"
done
