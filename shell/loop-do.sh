#!/bin/sh

trap 'exiting' EXIT

cmd="$*"

while true; do
	read parameter
	$cmd $parameter
done
