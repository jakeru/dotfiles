#!/bin/bash

SCRIPT=$(realpath ${0})
SCRIPT_DIR=$(dirname ${SCRIPT})

# emacs
apt install --assume-yes aspell-sv
apt install --assume-yes ripgrep
apt install --assume-yes editorconfig

# irony-server (in emacs)
apt install --assume-yes cmake
apt install --assume-yes g++
apt install --assume-yes clang libclang-dev

# doom (in emacs)
apt install --assume-yes fd-find

# python (in emacs)
apt install --assume-yes isort
apt install --assume-yes python2-pytest
apt install --assume-yes python3-pytest

# markdown (in emacs)
apt install --assume-yes markdown

# cc (in emacs)
apt install --assume-yes rtags

# bash (in emacs)
apt install --assume-yes shellcheck

# org-realm (emacs)
apt install --assume-yes graphviz
apt install --assume-yes sqlite3

# python (emacs and others)
apt install --assume-yes pipenv

# access python3 using python
update-alternatives --install /usr/local/bin/python python /usr/bin/python3 40

# x
apt install --assume-yes xcape

# zsh
apt install --assume-yes zsh

# misc
apt install --asume-yes curl python3-venv

# feh
apt install --assume-yes feh

# touchpad
ln --symbolic --force "$(realpath "${SCRIPT_DIR}/x/90-touchpad.conf")" \
    /usr/share/X11/xorg.conf.d/.
