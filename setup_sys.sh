#!/bin/bash

SCRIPT=$(realpath ${0})
SCRIPT_DIR=$(dirname ${SCRIPT})

# emacs
apt install aspell-sv
apt install ripgrep
apt install editorconfig

# irony-server (in emacs)
apt install cmake
apt install g++
apt install clang libclang-dev

# doom (in emacs)
apt install fdclone

# python (in emacs)
apt install isort

# markdown (in emacs)
apt install markdown

# cc (in emacs)
apt install rtags

# bash (in emacs)
apt install shellcheck

# access python3 using python
update-alternatives --install /usr/local/bin/python python /usr/bin/python3 40

# x
apt install xcape

# touchpad
ln --symbolic --force "$(realpath "${SCRIPT_DIR}/x/90-touchpad.conf")" \
    /usr/share/X11/xorg.conf.d/.
