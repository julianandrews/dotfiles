#!/usr/bin/env sh

CACHE_DIR="/var/cache/page-status"
ERROR_COLOR="#cb4b16"

site_status() {
  cat "$CACHE_DIR/$1"
}

for entry in "$@"
do
  set -- $entry
  site="$1"
  status="$2"
  output="$3"
  [ "$(site_status "$site")" = "$status" ] || echo -n "<fc=$ERROR_COLOR><fn=1>$output</fn></fc> | "
done
