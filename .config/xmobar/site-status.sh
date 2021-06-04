site_status() {
  site="$1"
  curl -sL -w "%{http_code}\\n" "$site" -o /dev/null
}

for entry in "https://jellyfin.seemyvest.net 200 " "https://wiki.seemyvest.net 401 "
do
  set -- $entry
  site="$1"
  status="$2"
  output="$3"
  [ "$(site_status "$site")" = "$status" ] || echo -n "<fc=#cb4b16><fn=1>$output</fn></fc> | "
done
