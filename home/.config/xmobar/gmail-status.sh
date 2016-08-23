#!/usr/bin/env sh

pipe=/tmp/.gmail-pipe
lock=/tmp/.gmail-pipe-lock
gmailcount=/home/julian/.local/bin/gmailcount

case $(hostname) in
  orpheus)     email='jandrews@fusionbox.com'; url='https://mail.google.com' ;;
  *)           email='jandrews271@gmail.com'; url='https://inbox.google.com' ;;
esac

release_lock() {
  rm -f "$lock"
}

get_lock() {
  [ -e "$lock" ] && kill -0 "$(<$lock)" 2>/dev/null || release_lock
  [ ! -e "$lock" ] && echo "$$" > "$lock" || return 1
}

echo_status() {
  echo "<action=\`xdg-open $url\`><fc=$2><fn=1></fn> $1</fc></action>"
}

write_to_fifo() {
  get_lock || return 1
  full_text=$("$gmailcount" "$email")
  full_text=${full_text:-?}

  case $full_text in
    ''|*[!0-9]*) color=\#dc322f ;;
    0)           color=\#586e75 ;;
    *)           color=\#2AA198 ;;
  esac

  echo_status "$full_text" "$color" > "$pipe"
  release_lock
}

[ ! -p "$pipe" ] && mkfifo "$pipe"
output=$(dd if="$pipe" iflag=nonblock 2>/dev/null | tail -n1 | xargs)
[ ! -z "$output" ] && echo "$output" || echo_status "?" \#6c71c4
write_to_fifo &
