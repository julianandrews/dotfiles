# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoredups:erasedups
HISTSIZE=10000
HISTFILESIZE=10000

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

### PROMPT ###

source ~/.fig_prompt

__ps1_prefix() {
  local ps1_prefix="${debian_chroot:+($debian_chroot)}"
  if is_fig_client; then
    ps1_prefix="$ps1_prefix[$(get_fig_client_name)]"
  fi

  printf "${1-%s}" "$ps1_prefix"
}

__ps1_host() {
  if [ -n "${SSH_TTY}" ]; then
    local ps1_host="${USER}@${HOSTNAME%%.*}"
    printf "${1-%s}" "$ps1_host"
  fi
}

__ps1_pwd() {
  local ps1_pwd="$PWD"

  if is_fig_client; then
    local client_root="$(get_fig_client_root)"
    ps1_pwd="/${PWD##${client_root}}"
    [[ "$ps1_pwd" =~ //google3/java/com/google(.*) ]] && ps1_pwd="(jcg)${BASH_REMATCH[1]}"
    [[ "$ps1_pwd" =~ //google3/javatests/com/google(.*) ]] && ps1_pwd="(jtcg)${BASH_REMATCH[1]}"
  else
    [[ "$ps1_pwd" =~ "$HOME"(.*) ]] && ps1_pwd="~${BASH_REMATCH[1]}"
  fi

  printf "${1-%s}" "$ps1_pwd"
}

__ps1_suffix() {
  if git --version &>/dev/null
  then
    export GIT_PS1_SHOWDIRTYSTATE=true
    export GIT_PS1_SHOWUNTRACKEDFILES=true
    local git_ps1="$(__git_ps1)"
  fi
  # local fig_ps1="$(get_fig_prompt)"
  local fig_ps1=""

  printf "${1-%s}" "${git_ps1}${fig_ps1}"
}

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then # color works
  prefix_template="\[$(tput setaf 4)\]%s\[$(tput sgr0)\]"
  host_template="\[$(tput setaf 9)\]%s\[$(tput sgr0)\]:"
  pwd_template="\[$(tput setaf 6)\]%s\[$(tput sgr0)\]"
  suffix_template="\[$(tput setaf 5)\]%s\[$(tput sgr0)\]"
else
  prefix_template="%s"
  host_template='%s:'
  pwd_template="%s"
  suffix_template='%s'
fi

PS1='$(__ps1_prefix "'$prefix_template'")$(__ps1_host "'$host_template'")$(__ps1_pwd "'$pwd_template'")$(__ps1_suffix "'$suffix_template'")\$ '
unset pwd_template host_template prefix_template suffix_template

### END PROMPT ###

# If this is an xterm set the title to user@host:dir
case "$TERM" in
  xterm*|rxvt*)
    if [ -n "${SSH_TTY}" ]; then
      PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    else
      PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\w\a\]$PS1"
    fi
    ;;
  *)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Python startup
export PYTHONSTARTUP=~/.pythonrc

# set default editor to vim
export EDITOR=vim

PATH=~/.local/bin:~/bin:/sbin:/usr/sbin:${PATH}

# dart binaries
export PATH=/usr/lib/google-dartlang/bin:${PATH}

# dart pub
export PATH=~/.pub-cache/bin:${PATH}

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='find * -path "*/\.*" -prune -o -type f -not -name "*.pyc" -print -o -type l -not -name "*.pyc" -print 2> /dev/null'
export FZF_DEFAULT_OPTS='--tiebreak=end,begin,length,index'

# bigstore
if [ -f /google/src/head/depot/google3/cloud/bigstore/tools/bigstore.bashrc ]; then
  . /google/src/head/depot/google3/cloud/bigstore/tools/bigstore.bashrc
fi

# blaze
export BLAZE_COMPLETION_USE_QUERY=true
