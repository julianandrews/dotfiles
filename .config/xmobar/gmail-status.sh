#!/usr/bin/env sh

STATUSFILE=/tmp/.gmail-status
GMAILCOUNT=/home/julian/.local/bin/gmailcount
SLEEPTIME=${1:-0}

case $(hostname) in
  orpheus)     EMAIL='jandrews@fusionbox.com'; URL='https://mail.google.com' ;;
  *)           EMAIL='jandrews271@gmail.com'; URL='https://inbox.google.com' ;;
esac

echo_status() {
  echo "<action=\`xdg-open $URL\`><fc=$2><fn=1></fn> $1</fc></action>"
}

write_data() {
  sleep "$SLEEPTIME"
  full_text=$("$GMAILCOUNT" "$EMAIL")
  full_text=${full_text:-?}

  case $full_text in
    ''|*[!0-9]*) color=\#dc322f ;;
    0)           color=\#586e75 ;;
    *)           color=\#2AA198 ;;
  esac

  echo_status "$full_text" "$color" > "$STATUSFILE"
}

touch "$STATUSFILE"
output=$(cat "$STATUSFILE")
[ ! -z "$output" ] && echo "$output" || echo_status "?" \#6c71c4
> "$STATUSFILE"
write_data &
