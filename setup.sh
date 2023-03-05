#!/bin/bash

set -e

# Get absolute path of a file.
# From:
# https://stackoverflow.com/questions/1055671/how-can-i-get-the-behavior-of-gnus-readlink-f-on-a-mac
readlinkf() {
    perl -MCwd -e 'print Cwd::abs_path shift' "$1"
}

# Create a symlink.
function symlink() {
    declare TARGET=$1
    declare LINK_NAME=$2
    if [ "$(readlinkf $LINK_NAME)" = "$TARGET" ]; then
        echo "Symlink $LINK_NAME already points to $TARGET"
    else
        echo "Creating symlink $LINK_NAME to $TARGET..."
        mkdir -p "$(dirname "$LINK_NAME")"
        ln -s "$TARGET" "$LINK_NAME"
    fi
}

# Download a file if it does not exist already.
function download() {
    declare SOURCE=$1
    declare TARGET=$2
    if [[ ! -f "$TARGET" ]]; then
        echo "Downloading $SOURCE to $TARGET..."
        mkdir -p "$(dirname "$TARGET")"
        wget "$SOURCE" --output-document "$TARGET"
    fi
}

# Make a directory
function makedir() {
    declare DIR=$1
    if [[ ! -d "$DIR" ]]; then
        echo "Creating directory $DIR..."
        mkdir -p "$DIR"
    fi
}

# Append something to a file if it does not already exists
function append_if_not_present() {
    declare FILE=$1
    declare LINE=$2
    if grep -xsqF -- "$LINE" "$FILE"; then
        echo "Line \'$LINE\' is already present in $FILE"
    else
        echo "Appending line \'$LINE\' to file $FILE"
        echo "$LINE" >> "$FILE"
    fi
}

function setup_emacs_no_longer_used() {
    echo Setting up Emacs...
    makedir "$HOME/.emacs.d"
    download \
        "https://raw.githubusercontent.com/hrs/sensible-defaults.el/main/sensible-defaults.el" \
        "downloads/emacs/sensible-defaults.el"
    symlink "$SCRIPT_DIR/emacs/init.el" "$HOME/.emacs.d/init.el"
    symlink "$SCRIPT_DIR/emacs/configuration.org" "$HOME/.emacs.d/configuration.org"
    symlink "$SCRIPT_DIR/downloads/emacs/sensible-defaults.el" "$HOME/.emacs.d/sensible-defaults.el"
}

function setup_doom_emacs() {
    echo Setting up Doom Emacs...
    makedir "$HOME/.doom.d"
    symlink "$SCRIPT_DIR/doom-emacs/config.el" "$HOME/.doom.d/config.el"
    symlink "$SCRIPT_DIR/doom-emacs/init.el" "$HOME/.doom.d/init.el"
    symlink "$SCRIPT_DIR/doom-emacs/packages.el" "$HOME/.doom.d/packages.el"
    symlink "$SCRIPT_DIR/doom-emacs/ispell-personal-dictionary-sv" "$HOME/.doom.d/ispell-personal-dictionary-sv"
    symlink "$SCRIPT_DIR/doom-emacs/ispell-personal-dictionary-english" "$HOME/.doom.d/ispell-personal-dictionary-english"
    if [[ ! -e "$HOME/.emacs.d/bin/doom" ]]; then
        echo Warning: Doom Emacs is not installed
        echo Install with:
        echo git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
    fi
    pip3 install cmake-language-server
}

function setup_inputrc() {
    echo Setting up inputrc...
    symlink "$SCRIPT_DIR/inputrc/dot.inputrc" "$HOME/.inputrc"
}

function setup_git() {
    echo Setting up git...
    symlink "$SCRIPT_DIR/git/dot.gitconfig" "$HOME/.gitconfig"
    symlink "$SCRIPT_DIR/git/dot.gitexcludes" "$HOME/.gitexcludes"
}

function setup_vscode() {
    echo Setting up Visual Studio Code...
    symlink "$SCRIPT_DIR/vscode/settings.json" "$HOME/.config/Code/User/settings.json"
}

function setup_bash() {
    echo Setting up bash...
    append_if_not_present "$HOME/.bashrc" 'for file in ~/.bashrc.d/*.sh; do source $file; done'
    makedir "$HOME/.bashrc.d"
    symlink "$SCRIPT_DIR/bash/misc.sh" "$HOME/.bashrc.d/misc.sh"
    download \
        "https://github.com/git/git/raw/master/contrib/completion/git-prompt.sh" \
        "downloads/bash/git-prompt.sh"
    symlink "$SCRIPT_DIR/downloads/bash/git-prompt.sh" "$HOME/.bashrc.d/git-prompt.sh"
}

function setup_phist() {
    echo Setting up phist..
    download \
        "https://raw.githubusercontent.com/jakeru/phist/master/phist.sh" \
        "downloads/phist/phist.sh"
    symlink "$SCRIPT_DIR/downloads/phist/phist.sh" "$HOME/.bashrc.d/phist.sh"
}

function setup_x() {
    echo Setting up X...
    symlink "$SCRIPT_DIR/x/dot.xsessionrc" "$HOME/.xsessionrc"
}

function setup_keyboard() {
    echo Setting up keyboard...
    symlink "$SCRIPT_DIR/keyboard/dot.Xmodmap" "$HOME/.Xmodmap"
}

function setup_i3() {
    echo Setting up i3...
    symlink "$SCRIPT_DIR/i3/config" "$HOME/.config/i3/config"
    symlink "$SCRIPT_DIR/i3/i3status" "$HOME/.config/i3status/config"
}

function setup_docker() {
    echo Setting up Docker...
    symlink "$SCRIPT_DIR/docker/config.json" "$HOME/.docker/config.json"
}

function setup_zsh() {
    echo Setting up zsh...
    symlink "$SCRIPT_DIR/zsh/dot.zshrc" "$HOME/.zshrc"
}

function setup_autorandr() {
    echo Setting up autorandr...
    symlink "$SCRIPT_DIR/autorandr" "$HOME/.config/autorandr"
}

function setup_ssh() {
    echo Setting up ssh...
    symlink "$SCRIPT_DIR/ssh/config" "$HOME/.ssh/config"
    symlink "$SCRIPT_DIR/ssh/wittra.cfg" "$HOME/.ssh/wittra.cfg"
    symlink "$SCRIPT_DIR/ssh/private.cfg" "$HOME/.ssh/private.cfg"
}

function setup_alacritty() {
    echo Setting up alacritty...
    symlink "$SCRIPT_DIR/alacritty/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml"
}

function setup_dot_profile() {
    echo Setting up .profile...
    symlink "$SCRIPT_DIR/dot.profile" "$HOME/.profile"
}

function setup_gdb() {
    echo Setting up gdb...
    symlink "$SCRIPT_DIR/gdb/gdbinit" "$HOME/.gdbinit"
}

function setup_zathura() {
    echo Setting up zathura...
    symlink "$SCRIPT_DIR/zathura/zathurarc" "$HOME/.config/zathura/zathurarc"
}

function setup_curl() {
    echo Setting up curl...
    symlink "$SCRIPT_DIR/curl/dot.curlrc" "$HOME/.curlrc"
}

function setup_nvim() {
    echo Setting up nvim...
    symlink "$SCRIPT_DIR/nvim" "$HOME/.config/nvim"
}

# Main

SCRIPT="$(readlinkf $0)"
SCRIPT_DIR="$(dirname $SCRIPT)"

setup_doom_emacs
setup_inputrc
setup_git
setup_vscode
setup_bash
setup_phist
setup_x
setup_keyboard
setup_i3
setup_docker
setup_zsh
setup_autorandr
setup_ssh
setup_alacritty
setup_dot_profile
setup_gdb
setup_zathura
setup_curl
setup_nvim

echo Operation completed.
