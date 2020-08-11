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
	    ln -s "$TARGET" "$LINK_NAME"
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

# Make a directory
function makedir() {
    declare DIR=$1
    if [[ ! -d "$DIR" ]]; then
        echo Creating directory $DIR...
        mkdir -p "$DIR"
    fi
}

# Append something to a file if it does not already exists
function append_if_not_present() {
    declare FILE=$1
    declare LINE=$2
    if grep -xsqF -- "$LINE" "$FILE"; then
        echo Line \'$LINE\' is already present in $FILE
    else
        echo Appending line \'$LINE\' to file $FILE
        echo "$LINE" >> "$FILE"
    fi
}

function setup_emacs() {
    echo Setting up Emacs...
    makedir "$HOME/.emacs.d"
    download \
        "https://raw.githubusercontent.com/hrs/sensible-defaults.el/main/sensible-defaults.el" \
        "downloads/emacs/sensible-defaults.el"
    symlink "$SCRIPT_DIR/emacs/init.el" "$HOME/.emacs.d/init.el"
    symlink "$SCRIPT_DIR/emacs/configuration.org" "$HOME/.emacs.d/configuration.org"
    symlink "$SCRIPT_DIR/downloads/emacs/sensible-defaults.el" "$HOME/.emacs.d/sensible-defaults.el"
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
}

function setup_phist() {
    echo Setting up phist..
    download \
        "https://raw.githubusercontent.com/jakeru/phist/master/phist.sh" \
        "downloads/phist/phist.sh"
    symlink "$SCRIPT_DIR/downloads/phist/phist.sh" "$HOME/.bashrc.d/phist.sh"
}

function setup_i3() {
    echo Setting up i3...
    symlink "$SCRIPT_DIR/i3/config" "$HOME/.config/i3/config"
}

# Main

SCRIPT="$(readlinkf $0)"
SCRIPT_DIR="$(dirname $SCRIPT)"

setup_emacs
setup_inputrc
setup_git
setup_vscode
setup_bash
setup_phist
setup_i3
echo Operation completed.
