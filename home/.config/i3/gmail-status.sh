!#/bin/bash

email_address='jandrews271@gmail.com'
[[ "$HOSTNAME" = "orpheus" ]] && email_address='jandrews@fusionbox.com'
[[ $BLOCK_BUTTON = 1 ]] && xdg-open https://inbox.google.com
count=$(~/bin/gmail_count "$email_address")
case "$count" in
  \?)
    color=\#FF0000
    ;;
  0)
    color=\#888888
    ;;
  *)
    color=\#00FF00
    ;;
esac

echo "$count"
echo
echo "$color"
