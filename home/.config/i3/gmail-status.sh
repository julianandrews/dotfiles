count=$(~/bin/gmail_count $1)
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
