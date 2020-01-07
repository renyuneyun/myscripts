#!/bin/sh

#######################################################
# This script mirrors a certain window, by using VNC. #
# It only works on X11 and requires X11VNC installed. #
#######################################################

WINDOW_ID=$(xwininfo | grep 'Window id' | sed 's/xwininfo: Window id: \([^ ]*\) .*/\1/')

echo $WINDOW_ID

x11vnc -id $WINDOW_ID & # Spawn x11vnc server in the background; it will be terminated automatically when the client closes
#TODO: capture the port and spawn successful state from x11vnc

sleep 4 # Wait for x11vnc to finish initialisation

vncviewer -ViewOnly ::5900 # By default x11vnc should put the port to 5900
