#!/bin/sh

## Complement hash to magnet link

printf "magnet:?xt=urn:btih:%s" $1
