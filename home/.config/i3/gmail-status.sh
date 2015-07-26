#!/bin/sh

[ "$BLOCK_BUTTON" = 1 ] && xdg-open https://inbox.google.com

case $(hostname) in
  orpheus)     email='jandrews@fusionbox.com' ;;
  *)           email='jandrews271@gmail.com' ;;
esac

full_text=$(~/bin/gmail-count "$email")

case $full_text in
  ''|*[!0-9]*) color=\#FF0000 ;;
  0)           color=\#888888 ;;
  *)           color=\#00FF00 ;;
esac

echo "$full_text"
echo "$short_text"
echo "$color"
