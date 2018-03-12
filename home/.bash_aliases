# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias launchpad='/google/data/ro/teams/ads-engprod/ap/tools/launchpad/launchpad_web.par'

alias newterm='urxvtc -cd "$PWD"'

alias set-monitors='xrandr --output DP-4 --auto --primary --output DP-5 --auto --right-of DP-4'

function pcat() {
    pygmentize -f terminal256 "${1:--}" 2> /dev/null || cat "${1:--}"
}

function pless(){
  pcat "$1" | less -R
}

function rgv() {
    vim -q <(rg -n "$@")
}

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

git() {
  merge_in_git5=false
  if [[ $1 == "merge" ]]; then
    git5_root_dir=$PWD
    while [[ -n "$git5_root_dir" ]]; do
      if [[ -d "$git5_root_dir/.git5_specs" ]]; then
        merge_in_git5=true
        break
      fi
      git5_root_dir=${git5_root_dir%/*}
    done
  fi

  if [[ $merge_in_git5 == "true" ]]; then
    cat << EOF
Use git5 merge, not git merge. git merge does not understand how
to merge the READONLY link and it can corrupt your branch, so stay
away from it. Type "unset -f git" to remove this warning.
EOF
  else
    /usr/bin/env git "$@"
  fi
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
