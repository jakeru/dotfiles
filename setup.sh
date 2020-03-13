#!/bin/sh
echo Setting up Emacs...
mkdir -p $HOME/.emacs.d
cp emacs/configuration.org $HOME/.emacs.d/.
cp emacs/init.el $HOME/.emacs.d/.
cp downloads/emacs/sensible-defaults.el $HOME/.emacs.d/.
