alias newterm='urxvtc -cd "$PWD"'

alias run_affected='/google/src/head/depot/google3/experimental/users/julianandrews/run_affected --nodirect --fig'

alias set-monitors='xrandr --output DP-4 --auto --primary --output DP-5 --auto --right-of DP-4'

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
  /usr/bin/prodaccess "$@" && /google/data/ro/users/di/diamondm/engfortunes/fortune.sh --extra_space
}

# toggles between .../java/... and .../javatests/...
function jt {
  NORMAL_DIR="${PWD/\/javatests\//\/java\/}"
  TEST_DIR="${PWD/\/java\//\/javatests\/}"
  if [[ ($NORMAL_DIR != $PWD) && (-d $NORMAL_DIR) ]]; then
    cd $NORMAL_DIR
  elif [[ ($TEST_DIR != $PWD) && (-d $TEST_DIR) ]]; then
    cd $TEST_DIR
  fi
}

function hge {
  local files
  IFS= readarray -d '' files < <(hg status --rev 'parents(".")' -mau0n 2>/dev/null)
  $EDITOR "${files[@]}" "$@"
}
