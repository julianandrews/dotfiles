#!/usr/bin/env sh

pipe=/tmp/.gmail-pipe
gmailcount=/home/julian/.local/bin/gmailcount

case $(hostname) in
  orpheus)     email='jandrews@fusionbox.com'; url='https://mail.google.com' ;;
  *)           email='jandrews271@gmail.com'; url='https://inbox.google.com' ;;
esac

write_to_fifo() {
  full_text=$("$gmailcount" "$email")
  full_text=${full_text:-?}

  case $full_text in
    ''|*[!0-9]*) color=\#dc322f ;;
    0)           color=\#586e75 ;;
    *)           color=\#2AA198 ;;
  esac

  echo "<action=\`xdg-open $url\`><fc=$color><fn=1></fn> $full_text</fc></action>" > "$pipe"
}

[ ! -p "$pipe" ] && mkfifo "$pipe"
dd if="$pipe" iflag=nonblock 2>/dev/null | tail -n1
write_to_fifo &
