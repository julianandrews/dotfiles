#!/bin/sh

[ "$BLOCK_BUTTON" = "1" ] && xdg-open https://inbox.google.com

case $(hostname) in
  orpheus)     email='jandrews@fusionbox.com' ;;
  *)           email='jandrews271@gmail.com' ;;
esac

count=$(~/bin/gmail_count "$email")

case $count in
  ''|*[!0-9]*) color=\#FF0000 ;;
  0)           color=\#888888 ;;
  *)           color=\#00FF00 ;;
esac

echo "$count"
echo
echo "$color"
