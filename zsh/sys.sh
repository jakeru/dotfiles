#!/usr/bin/env bash
set -euo pipefail

apt install fonts-powerline

echo 'deb http://download.opensuse.org/repositories/home:/Provessor/xUbuntu_20.04/ /' | tee /etc/apt/sources.list.d/home:Provessor.list
curl -fsSL https://download.opensuse.org/repositories/home:Provessor/xUbuntu_20.04/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/home_Provessor.gpg > /dev/null
apt update
apt install lf
