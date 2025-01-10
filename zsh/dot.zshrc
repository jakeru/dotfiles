# Inspired by
# https://github.com/BrodieRobertson/dotfiles
# and
# Luke's config for the Zoomer Shell
# https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# I use zplug from
# https://github.com/zplug/zplug
# as a zsh package manager
source ~/.zplug/init.zsh

# Enable colors
autoload -U colors && colors

# Basic auto/tab complete:
autoload -U compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' file-sort modification

# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zmodload zsh/complist
# Include hidden files.
_comp_options+=(globdots)

# Use viins as main keymap
bindkey -v

# Enable searching through history
bindkey '^R' history-incremental-pattern-search-backward

# Edit line in vim buffer ctrl-v
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line
# Enter vim buffer from normal mode
autoload -U edit-command-line && zle -N edit-command-line && bindkey -M vicmd "^v" edit-command-line

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'left' vi-backward-char
bindkey -M menuselect 'down' vi-down-line-or-history
bindkey -M menuselect 'up' vi-up-line-or-history
bindkey -M menuselect 'right' vi-forward-char

# Fix backspace bug when switching modes
bindkey "^?" backward-delete-char

# ci", ci', ci`, di", etc
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done

# ci{, ci(, ci<, di{, etc
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
# from Luke's config for the Zoomer Shell
# https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# My stuff

# When for example using `cd -` to go back to the previous directory do not
# print the directory. It will anyway be shown in the prompt.
setopt cd_silent

# Add a slash automatically when completing something that is a directory.
setopt auto_param_slash

# Do not exit when pressing ctrl+d.
# Note that zsh will exit anyway if ctrl+d is pressed 10 times.
setopt ignore_eof

# From Sharing history in zsh
# https://nuclearsquid.com/writings/shared-history-in-zsh/
# and https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/history.zsh
#setopt share_history
setopt hist_ignore_space
setopt hist_verify
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_fcntl_lock
setopt inc_append_history

HISTSIZE=10000
SAVEHIST=1000000
HISTFILE=~/.cache/zsh/history
mkdir -p "$(dirname "$HISTFILE")"

PHIST_DIR="$HOME/.persistent-history"

# Persistent history
persistent_history() {
  local now="$(date +%s --utc)"
  local year=$(date --date="@$now" +%Y --utc)
  local date=$(date --date="@$now" +%F --utc)
  local time=$(date --date="@$now" +%T --utc)
  local host=${HOST:-unknown}
  local user=${USER:-unknown}
  local file="${PHIST_DIR}/$(date +%Y)/$(date +%F)_$$_${user}_${host}.txt"
  local cmd=$(echo -n "$1" | tr '\n' ';')
  mkdir -p "$(dirname "${file}")"
  echo "${date} ${time} | ${cmd}" >> $file
}

lhist() {
  fc -L 1
}

zle -N lhist

alias phist="find ${PHIST_DIR} -type f | sort -r | xargs cat | less"
alias phgrep="find ${PHIST_DIR} -type f | sort -r | xargs grep --no-filename"

autoload -U add-zsh-hook
add-zsh-hook preexec persistent_history

# A few plugins
zplug "MichaelAquilina/zsh-you-should-use", at:1.7.3
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "agkozak/zsh-z"
zplug "zsh-users/zsh-autosuggestions", at:0.7.0

# Agnoster prompt
zplug "agnoster/agnoster-zsh-theme", as:theme
DEFAULT_USER=${USER}

# My keys
# Note: run `bindkey` without paramters to see current key bindings.
bindkey -v
bindkey '^a' vi-beginning-of-line
bindkey '^b' vi-backward-char
bindkey '^d' vi-delete-char
bindkey '^e' vi-end-of-line
bindkey '^f' vi-forward-char
bindkey '^h' vi-backward-delete-char
bindkey '^k' vi-kill-eol
bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward
bindkey '^w' backward-kill-word

# ctrl+left
bindkey '^[[1;5D' backward-word

# ctrl+right
bindkey '^[[1;5C' forward-word

# My aliases
alias ls='ls --color=auto'
# Search for a command in the persistent history file.
#alias phgrep='cat ~/.persistent_history|grep'
# See the latest executed commands stored in the persistent history file.
#alias phist='tail -n 50 ~/.persistent_history'

alias tt="tree --dirsfirst"
alias ff="find . -type f"
alias ll="ls -lah"

alias c="batcat"

# Many hosts are not happy with my alacritty terminal emulator, so pretend
# that we are using something else.
alias ssh="TERM=xterm-color ssh"

# Platform IO
path+=("$HOME/.platformio/penv/bin")

# Nix
path+=(/nix/store/nzp4m3cmm7wawk031byh8jg4cdzjq212-nix-2.3.16/bin)

# pyenv https://github.com/pyenv/pyenv
PYENV_ROOT="$HOME/prog/apps/pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

#
# zplug post process
#

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
      print -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
      print -n "%{%k%}"
  fi

  print -n "%{%f%}"
  CURRENT_BG=''

  # Adds a new line.
  printf "\n#";
}


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
