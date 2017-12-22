# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
HISTSIZE=5000
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

# uncomment the line below to force color if supported
# force_color_prompt=yes
if [ -n "$force_color_prompt" ] || [[ "$TERM" == *color* ]]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=yes
  else
    color_prompt=
  fi
fi

__p4_ps1() {
  local p4_client="$(which g4 && g4 set P4CLIENT -q | cut -s -d: -f2)"

  if [ -z "$p4_client" ]; then
    PS1_PWD="$(dirs | cut -d' ' -f1)"
    PS1_PREFIX="${debian_chroot:+($debian_chroot)}"
  else
    local client_root="$(g4 --format '%clientRoot%' info)"
    local rel_path="/${PWD##${client_root}}"
    [[ "$rel_path" =~ //google3/java/com/google(.*) ]] && rel_path="(jcg)${BASH_REMATCH[1]}"
    [[ "$rel_path" =~ //google3/javatests/com/google(.*) ]] && rel_path="(jtcg)${BASH_REMATCH[1]}"
    [[ "$rel_path" =~ //google3/ads/crm/gamma(.*) ]] && rel_path="(gamma)${BASH_REMATCH[1]}"
    PS1_PWD="$rel_path"
    PS1_PREFIX="${debian_chroot:+($debian_chroot)}[$p4_client] "
  fi
}

PROMPT_COMMAND="__p4_ps1"

if [ "$color_prompt" = yes ]; then
  if [ -n "${SSH_TTY}" ]; then
    PS1='\[\e[35m\]${PS1_PREFIX}\[\e[32m\]\u@\h\[\e[0m\]:\[\e[36m\]${PS1_PWD}\[\e[0m\] $ '
  else
    PS1='\[\e[35m\]${PS1_PREFIX}\[\e[36m\]${PS1_PWD}\[\e[0m\] $ '
  fi
else
  if [ -n "${SSH_TTY}" ]; then
    PS1='${PS1_PREFIX}\u@\h:${PS1_PWD} $ '
  else
    PS1='${PS1_PREFIX}${PS1_PWD} $ '
  fi
fi
unset color_prompt force_color_prompt

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

# setup git prompt
if git --version &>/dev/null
then
  export GIT_PS1_SHOWDIRTYSTATE=true
  export GIT_PS1_SHOWUNTRACKEDFILES=true
  export PS1="${PS1:0:-3}\$(__git_ps1 \" \[\033[1;35m\](%s)\[\033[00m\]\") \$ "
fi

# set default editor to vim
export EDITOR=vim

# python 2 tab completion
export PYTHONSTARTUP=~/.config/pystartup

PATH=$PATH:~/.local/bin:~/bin:/sbin:/usr/sbin

# dart binaries
export PATH=/usr/lib/google-dartlang/bin:${PATH}

# dart pub
export PATH=$PATH:~/.pub-cache/bin

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='find * -path "*/\.*" -prune -o -type f -not -name "*.pyc" -print -o -type l -not -name "*.pyc" -print 2> /dev/null'
export FZF_DEFAULT_OPTS='--tiebreak=end,begin,length,index'

