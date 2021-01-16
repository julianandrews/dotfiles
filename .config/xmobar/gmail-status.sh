#!/usr/bin/env sh

GMAILCOUNT=/home/julian/.local/bin/gmailcount
SLEEPTIME=${1:-5}
EMAIL='jandrews271@gmail.com'
URL='https://mail.google.com'

echo_status() {
  echo "<action=\`xdg-open $URL\`><fc=$2><fn=1></fn> $1</fc></action>"
}

get_status_output() {
  full_text=$("$GMAILCOUNT" "$EMAIL")
  full_text=${full_text:-?}

  case $full_text in
    ''|*[!0-9]*) color=\#dc322f ;;
    0)           color=\#586e75 ;;
    *)           color=\#2AA198 ;;
  esac

  echo_status "$full_text" "$color"
}

echo_status "?" \#6c71c4
while :; do
  get_status_output
  sleep "$SLEEPTIME"
done
