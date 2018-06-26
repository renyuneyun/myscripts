#!/bin/bash

function print_help {
	echo $0 \'ssh_args\' \'remote_file\' \'gpg_args\'
	echo
	echo Detach-sign a remote file using gpg.
}

if [ $# -ne 3 ]; then
	print_help
	exit 1
fi

if [[ "$*" =~ "-h" ]]; then
	print_help
	exit 0
fi

ssh_args=$1
remote_file=$2
gpg_args=$3

ssh $ssh_args "cat $remote_file" | gpg --detach-sign $gpg_args - | ssh $ssh_args "cat > $remote_file.sig"
