#!/usr/bin/sh

if [ -z "$*" ]; then
	exit
fi
export WINEARCH=win32
export WINEPREFIX=$HOME/.wine32
$*
