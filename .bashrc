# If not running interactively, skip the config
[[ $- == *i* ]] || return

# Configure history
HISTFILE="$HOME/.local/share/bash/history"
HISTCONTROL=ignoreboth
HISTSIZE=5000
HISTFILESIZE=100000
shopt -s histappend
export PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"

# Enable globstar
shopt -s globstar

# Enable bash completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Config env vars
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export SSH_ASKPASS="$HOME/.local/bin/ssh-askpass-pass"
export SSH_ASKPASS_REQUIRE=prefer
export PYTHON_HISTORY="$HOME/.local/share/python/history"
export CARGO_HOME=~/.local/share/cargo
export RUSTUP_HOME=~/.local/share/rustup
export R_ENVIRON_USER=${XDG_CONFIG_HOME:-$HOME/.config}/R/REnviron
export PATH="$HOME/.opencode/bin:$HOME/.local/share/cargo/bin:$HOME/.local/bin:$PATH"

# Configure Tools
command -v nvim &>/dev/null && export EDITOR=nvim
command -v fzf &>/dev/null && eval "$(fzf --bash)"
command -v fnm &>/dev/null && eval "$(fnm env --use-on-cd --shell bash)"
if command -v starship &> /dev/null; then
  eval "$(starship init bash)"
  function set_win_title(){
    echo -ne "\033]0; ${PWD/$HOME/\~} \007"
  }
  starship_precmd_user_func="set_win_title"
fi

# Set Aliases and functions
alias ls='ls --color=auto'
alias grep='grep --color=auto'
dotfiles() { git --git-dir="$HOME/.dotfiles/shared" --work-tree="$HOME" "$@"; }
dotfiles-local() { git --git-dir="$HOME/.dotfiles/local" --work-tree="$HOME" "$@"; }
