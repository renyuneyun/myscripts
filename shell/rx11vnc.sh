#!/bin/bash

# Remote X11VNC server deployment
# use ssh reverse proxy
#
# require server's sshd_config set 'GatewayPorts yes'

#References:
# http://www.netcan666.com/2016/09/28/ssh%E9%9A%A7%E9%81%93%E5%8F%8D%E5%90%91%E4%BB%A3%E7%90%86%E5%AE%9E%E7%8E%B0%E5%86%85%E7%BD%91%E5%88%B0%E5%85%AC%E7%BD%91%E7%AB%AF%E5%8F%A3%E8%BD%AC%E5%8F%91/
# https://wiki.archlinux.org/index.php/X11vnc

if [[ "$*" =~ '-i' ]]; then
	inter=true
else
	inter=false
fi

if $inter; then
	echo Enter your proxy server address:
	read server
else
	server=$1
fi

if $inter; then
	echo Copy ssh_key to server?
	read cpkey
else
	cpkey=false
fi
if $cpkey; then
	ssh-copy-id $server
fi

if $inter; then
	echo Enter target port:
	read tport
else
	tport=8765
fi
ssh -fNR $tport:localhost:5900 $server

if $inter; then
	echo Enter your VNC password:
	read password
else
	password=$2
fi

if [ -z $password ]; then
	x11vnc -display :0 -auth ~/.Xauthority
else
	x11vnc -display :0 -passwd $password
fi

