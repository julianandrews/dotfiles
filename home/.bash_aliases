alias run_affected='/google/src/head/depot/google3/experimental/users/julianandrews/run_affected --nodirect --fig'

alias set-monitors='xrandr --output DP-4 --auto --primary --output DP-5 --auto --right-of DP-4'

alias iwyu="/google/src/head/depot/google3/devtools/maintenance/include_what_you_use/iwyu.py --nosafe_headers"

alias flex="/usr/bin/flex.par"

alias f1-sql="/google/data/ro/projects/storage/f1/tools/f1-sql"

function ptouch() {
    while [ -n "$1" ]
    do
      install -D -m 644 /dev/null "$1"
      shift
    done
}

alias br='/google/src/head/depot/google3/devtools/blaze/scripts/blaze-run.sh'

alias btcfg=/google/data/ro/projects/bigtable/contrib/btcfg/btcfg

function prodaccess() {
  /usr/bin/prodaccess "$@" && /google/data/ro/users/di/diamondm/engfortunes/fortune.sh --android_say | /usr/games/lolcat && bigstore_aliases
}

function bigstore_aliases() {
  if [ -f /google/src/head/depot/google3/cloud/bigstore/tools/bigstore.bashrc ]; then
    . /google/src/head/depot/google3/cloud/bigstore/tools/bigstore.bashrc
  fi
}

function hge {
  local files
  IFS= readarray -d '' files < <(hg status --rev p4base -mau0n 2>/dev/null)
  $EDITOR "${files[@]}" "$@"
}

bigstore_aliases

alias gs-oauth-prod="/google/data/ro/projects/cloud/bigstore/mpm/gs_oauth/live/gs_oauth.par \
  --client_id=909320924072.apps.googleusercontent.com \
  --client_secret=p3RlpR10xMFh9ZXBS/ZNLYUu \
  --scope='https://www.googleapis.com/auth/cloud-platform' \
  --scope='https://www.googleapis.com/auth/devstorage.full_control' \
  -f ~/.oauth2-prod.dat \
  --authorization_header=true"

httpa () { http "$@" "`gs-oauth-prod`"; }

alias @dbg=/google/bin/releases/ads-test-debugger/public/atdbg.par
