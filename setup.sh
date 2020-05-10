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
	    echo Symlink $LINK_NAME already points to $TARGET
    else
	    echo Creating symlink $LINK_NAME to $TARGET...
	    ln --symbolic "$TARGET" "$LINK_NAME"
    fi
}

# Download a file if it does not exist already.
function download() {
    declare SOURCE=$1
    declare TARGET=$2
    if [[ ! -f "$TARGET" ]]; then
        echo Downloading $SOURCE to $TARGET...
        mkdir -p "$(dirname "$TARGET")"
        wget "$SOURCE" --output-document "$TARGET"
    fi
}

function makedir() {
    declare DIR=$1
    if [[ ! -d "$DIR" ]]; then
        echo Creating directory $DIR...
        mkdir -p "$DIR"
    fi
}

function setup_emacs() {
    echo Setting up Emacs...
    makedir "$HOME/.emacs.d"
    download \
        "https://raw.githubusercontent.com/hrs/sensible-defaults.el/master/sensible-defaults.el" \
        "downloads/emacs/sensible-defaults.el"
    symlink "$SCRIPT_DIR/emacs/init.el" "$HOME/.emacs.d/init.el"
    symlink "$SCRIPT_DIR/emacs/configuration.org" "$HOME/.emacs.d/configuration.org"
    symlink "$SCRIPT_DIR/downloads/emacs/sensible-defaults.el" "$HOME/.emacs.d/sensible-defaults.el"
}

function setup_inputrc() {
    echo Setting up inputrc...
    symlink "$SCRIPT_DIR/inputrc/dot.inputrc" "$HOME/.inputrc"
}

setup_git() {
    echo Setting up git...
    symlink "$SCRIPT_DIR/git/dot.gitconfig" "$HOME/.gitconfig"
}

# Main

SCRIPT="$(readlinkf $0)"
SCRIPT_DIR="$(dirname $SCRIPT)"

setup_emacs
setup_inputrc
setup_git

echo Operation completed.
