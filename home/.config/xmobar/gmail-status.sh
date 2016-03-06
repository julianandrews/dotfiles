#!/usr/bin/env sh

case $(hostname) in
  orpheus)     email='jandrews@fusionbox.com'; url='https://mail.google.com' ;;
  *)           email='jandrews271@gmail.com'; url='https://inbox.google.com' ;;
esac

full_text=$(~/.local/bin/gmailcount "$email")
full_text=${full_text:-?}

case $full_text in
  ''|*[!0-9]*) color=\#dc322f ;;
  0)           color=\#888888 ;;
  *)           color=\#2AA198 ;;
esac

echo "<action=\`xdg-open $url\`><fc=$color>✉ $full_text</fc></action>"
