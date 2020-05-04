#!/bin/sh

set -e

# From:
# https://stackoverflow.com/questions/1055671/how-can-i-get-the-behavior-of-gnus-readlink-f-on-a-mac
readlinkf(){ perl -MCwd -e 'print Cwd::abs_path shift' "$1";}

SCRIPT="$(readlinkf $0)"
DIR="$(dirname $SCRIPT)"

echo Setting up Emacs...
mkdir -p $HOME/.emacs.d

EMACS_FILES=("configuration.org" "init.el" "sensible-defaults.el")

for f in ${EMACS_FILES[@]};
do
    TO=$DIR/emacs/$f
    FROM=$HOME/.emacs.d/$f
    if [ "$(readlinkf $FROM)" = "$TO" ]; then
	echo Symlink $FROM already pointing to $TO
    else
	Echo Creating symlink "$FROM" to "$TO"...
	ln -s "$TO" "$FROM"
    fi
done

echo Operation completed.

echo Setting up inputrc...
cp inputrc/dot.inputrc $HOME/.inputrc
echo Setting up git...
cp git/dot.gitconfig $HOME/.gitconfig
