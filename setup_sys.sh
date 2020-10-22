#!/bin/bash

# emacs
apt install aspell-sv

# x
apt install xcape

# touchpad
ln --symbolic --force "$(realpath x/90-touchpad.conf)" /usr/share/X11/xorg.conf.d/.
