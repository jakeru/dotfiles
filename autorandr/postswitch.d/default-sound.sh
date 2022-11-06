#!/usr/bin/env bash

echo Using default sink output to disable HDMI output
/usr/bin/pactl set-default-sink alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__sink
