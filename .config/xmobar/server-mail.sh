#!/usr/bin/env sh

SERVER="$1"
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/server-mail"
CACHE_FILE="$CACHE_DIR/$SERVER"

check_mail() {
  # SSH into $1 check if there's mail, and write the result out to $CACHE_FILE
  result=$(ssh "$1" '[ -s "/var/mail/$USER" ] && echo yes || echo no')
  mkdir -p "$CACHE_DIR"
  if [ $? = 255 ]; then
    # ssh returns 255 on a failed connection
    echo 'error' > "$CACHE_FILE"
  else
    echo "$result" > "$CACHE_FILE"
  fi
}

# Fetch the results from last run
case "$(cat "$CACHE_FILE")" in
  "yes")
    status='<fc=#b48900><fn=1></fn></fc>'
    ;;
  "no")
    status='<fc=#268bd2>✓</fc>'
    ;;
  *)
    status='<fc=#cb4b16><fn=1></fn></fc>'
    ;;
esac

# Check for mail asynchrously for next run.
check_mail "$SERVER" &

echo "<action=\`urxvt -e ssh $SERVER\`><fn=1></fn> $status</action>"
