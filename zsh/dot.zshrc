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

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select

# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zmodload zsh/complist
compinit
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

# Do not exit when pressing ctrl+d.
# Note that zsh will exit anyway if ctrl+d is pressed 10 times.
setopt ignore_eof

# From Sharing history in zsh
# https://nuclearsquid.com/writings/shared-history-in-zsh/
# and https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/history.zsh
setopt share_history
setopt extended_history
setopt hist_ignore_space
setopt hist_verify

# Persistent history
persistent_history() {
  #echo First argument: "$1"
}

autoload -U add-zsh-hook
add-zsh-hook preexec persistent_history

# A few plugins
zplug "MichaelAquilina/zsh-you-should-use", at:1.7.3
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "agkozak/zsh-z"

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
bindkey '^n' history-beginning-search-backward
bindkey '^w' backward-kill-word

# My aliases
alias ls='ls --color=auto'

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
