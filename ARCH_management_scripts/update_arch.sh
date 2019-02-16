#!/bin/bash

COMMAND=$1
SHUTDOWN_TIME=$2

sudo git -C /opt/pikaur/ pull
rm -rf ~/.libvirt
yes | sudo pacman -Scc
sudo mount -o remount,rw /dev/sda1 /boot
sudo pacman -Syyuu
printf 'y\n' | pikaur.py -Syyuu
yes | sudo pacman -Scc

if [[ $COMMAND == "--shutdown" ]]; then
    shutdown $SHUTDOWN_TIME
fi

# Sources:
# https://askubuntu.com/questions/338857/automatically-enter-input-in-command-line/338860#338860
