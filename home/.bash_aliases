# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias launchpad='/google/data/ro/teams/ads-engprod/ap/tools/launchpad/launchpad_web.par'

alias newterm='urxvtc -cd "$PWD"'

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
