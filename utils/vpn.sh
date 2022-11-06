#!/usr/bin/env bash

# install:
# apt install openconnect openvpn --yes

openvpn --mktun --dev tun1
ifconfig tun1 up
openconnect vpn.prevas.se --interface tun1 --user jakru --authgroup 2
