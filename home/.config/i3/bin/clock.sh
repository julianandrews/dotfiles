#!/bin/sh

[ "$BLOCK_BUTTON" = 1 ] && xdg-open https://calendar.google.com &> /dev/null

date '+%a %b %d %l:%M %p'
