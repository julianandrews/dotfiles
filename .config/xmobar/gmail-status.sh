#!/usr/bin/env sh

EMAIL='jandrews271@gmail.com'
URL='https://mail.google.com'
CACHE_DIR=${XDG_CACHE_HOME:-/home/julian/.cache}

echo_status() {
  echo "<action=\`xdg-open $URL\`><fc=$2><fn=1></fn> $1</fc></action>"
}

get_status_output() {
  full_text=$(cat "$CACHE_DIR/gmailcount/$EMAIL")
  full_text=${full_text:-?}

  case $full_text in
    ''|*[!0-9]*) color=\#dc322f ;;
    0)           color=\#586e75 ;;
    *)           color=\#2AA198 ;;
  esac

  echo_status "$full_text" "$color"
}

get_status_output
