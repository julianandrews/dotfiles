#!/usr/bin/env sh

SERVER="$1"
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/server-mail"
CACHE_FILE="$CACHE_DIR/$SERVER"

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

echo "<action=\`urxvt -e ssh $SERVER\`><fn=1></fn> $status</action>"
