#!/bin/zsh

trap 'echo SIGEXIT received: exiting' EXIT

if [ $# -lt 1 ]; then
	echo "must specify a directory"
	exit;
fi
cd $1;
A=0
r_update() {
	if [ -d .git ]; then
		let A=A+1;
		echo "`pwd` TYPE:git";
		git fetch --all && git pull && git submodule sync && git submodule update --recursive --checkout;
	elif [ -d .hg ]; then
		let A=A+1;
		echo "`pwd` TYPE:hg";
		hg pull;
	elif [ -d .svn ]; then
		let A=A+1;
		echo "`pwd` TYPE:svn";
		svn update;
	else
		for file in `ls`; do
			if [ -d $file ]; then
				cd $file;
				r_update;
				cd ..;
			fi
		done
	fi;
}
r_update;
echo "Total repos: $A"
