#!/usr/bin/env sh

PIPE=/tmp/.gmail-pipe
LOCK=/tmp/.gmail-pipe-lock
GMAILCOUNT=/home/julian/.local/bin/gmailcount
SLEEPTIME=${1:-0}

case $(hostname) in
  orpheus)     EMAIL='jandrews@fusionbox.com'; URL='https://mail.google.com' ;;
  *)           EMAIL='jandrews271@gmail.com'; URL='https://inbox.google.com' ;;
esac

release_lock() {
  rm -f "$LOCK"
}

get_lock() {
  [ -e "$LOCK" ] && kill -0 "$(<$LOCK)" 2>/dev/null || release_lock
  [ ! -e "$LOCK" ] && echo "$$" > "$LOCK" || return 1
}

echo_status() {
  echo "<action=\`xdg-open $URL\`><fc=$2><fn=1></fn> $1</fc></action>"
}

write_to_fifo() {
  get_lock || return 1
  sleep "$SLEEPTIME"
  full_text=$("$GMAILCOUNT" "$EMAIL")
  full_text=${full_text:-?}

  case $full_text in
    ''|*[!0-9]*) color=\#dc322f ;;
    0)           color=\#586e75 ;;
    *)           color=\#2AA198 ;;
  esac

  echo_status "$full_text" "$color" > "$PIPE"
  release_lock
}

[ ! -p "$PIPE" ] && mkfifo "$PIPE"
output=$(dd if="$PIPE" iflag=nonblock 2>/dev/null | tail -n1 | xargs)
[ ! -z "$output" ] && echo "$output" || echo_status "?" \#6c71c4
write_to_fifo &
