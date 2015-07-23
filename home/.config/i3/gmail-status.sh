!#/bin/sh

if [ "$(hostname)" = "orpheus" ]
then
  email_address='jandrews@fusionbox.com'
else
  email_address='jandrews271@gmail.com'
fi

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
