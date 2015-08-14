#!/bin/bash

urlfile='urls'

urls=`cat $urlfile`
for url in $urls; do
	if [ ! $(echo $url | grep '#.*') ]; then
		you-get $url
	fi
done
