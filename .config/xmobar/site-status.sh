#!/usr/bin/env sh

CACHE_DIR=${XDG_CACHE_HOME:-/home/julian/.cache}

site_status() {
  cat "$CACHE_DIR/site-status/$1"
}

for entry in "jellyfin.seemyvest.net 200 "
do
  set -- $entry
  site="$1"
  status="$2"
  output="$3"
  [ "$(site_status "$site")" = "$status" ] || echo -n "<fc=#cb4b16><fn=1>$output</fn></fc> | "
done
