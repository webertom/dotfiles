#!/bin/bash

sink=0

pactl set-sink-mute "$sink" toggle

# i3blocks
pkill --signal SIGRTMIN+14 i3blocks
