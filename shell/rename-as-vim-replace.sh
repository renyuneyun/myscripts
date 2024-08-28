#!/bin/sh

EXECUTABLE=false

usage() {
	echo
	printf "Usage: %s [-e|--executable]\n" "$0"
	echo
	printf "Convert renaming list to vim replacement commands, optionally merging those as single executable command"
}

while [[ $# -gt 0 ]]; do
	case $1 in
		-e|--executable)
			EXECUTABLE=true
			shift
			;;
		*)
			echo "Invalid option: $1"
			usage
			exit 1
			;;
	esac
done

postprocess() {
	if [ $EXECUTABLE = true ]; then
		sed '$!s/$/ |/' | sed '2,$s/^/ /' | tr -d '\n'
	else
		cat
	fi
}

main() {
	sed -E 's| *(.*) -> (.*) *$|%s/\1/\2/gc|' | postprocess
}

main
