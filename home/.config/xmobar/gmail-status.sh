#!/bin/sh

case $(hostname) in
  orpheus)     email='jandrews@fusionbox.com' ;;
  *)           email='jandrews271@gmail.com' ;;
esac

full_text=$(~/.local/bin/gmail-count "$email")

case $full_text in
  ''|*[!0-9]*) color=\#dc322f ;;
  0)           color=\#888888 ;;
  *)           color=\#2AA198 ;;
esac

echo "<action=\`xdg-open https://inbox.google.com && xdotool key 'super+3'\`><fc=$color>✉ $full_text</fc></action>"
