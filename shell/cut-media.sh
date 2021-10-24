#!/bin/bash

function print_help {
	echo -e Cut the media file with the given durations removed, without re-encoding
	echo -e "  Supports cutting from the beginning (head) and the end (tail)"
	echo -e Usage:
	echo -e "  $0 INPUT_FILE OUTPUT_FILE [head DURATION] [tail DURATION]"
	echo -e
	echo -e "  " The "head" and "tail" can be repeated arbitrary times
	echo -e
	echo -e Example:
	echo -e "  " $0 my_source.ogg my_output.ogg head 4 tail 15
	echo -e "  " Remove the first 4s and final 15s from the media file my_source.ogg and store the result in my_output.ogg
	echo
	echo -e "Note: It will clean the temporary files if everything goes normal. However, if anything goes abnormal, you may want to manually clean the temporary file. They are named as /tmp/cut-media.\*"
}

if [ $# -lt 4 ]; then
	print_help
	exit 0
fi


function cut_head {
	f_in="$1"
	f_out="$2"
	dur="$3"  # Duration, in seconds

	ffmpeg -i "$f_in" -ss $dur -c copy "$f_out"
}

function cut_tail {
	# Obtained from https://askubuntu.com/questions/1352896/how-to-remove-last-4-seconds-of-mp3-file
	f_in="$1"
	f_out="$2"
	dur="$3"  # Duration, in seconds

	ffmpeg -i "$f_in" -ss $dur -i "$f_in" -c copy -map 0:a -map 1:a -shortest -f nut - | ffmpeg -y -f nut -i - -c copy -map 0:0 "$f_out"
}

filename_input="$1"
shift
filename_output="$1"
shift

function get_suffix {
	filename=$(basename -- "$1")
	suffix="${filename##*.}"
	echo $suffix
}

suffix=$(get_suffix $filename_input)
TMP_TEMPLATE="/tmp/cut-media.XXXXXX.$suffix"

tmp=$(mktemp $TMP_TEMPLATE)
cp "$filename_input" $tmp

while [ ! -z $1 ]; do
	case "$1" in
		head | h )
			shift
			duration=$1
			shift
			tmp2=$(mktemp $TMP_TEMPLATE)
			rm $tmp2
			cut_head $tmp $tmp2 $duration
			rm $tmp
			tmp=$tmp2
			;;
		tail | t )
			shift
			duration=$1
			shift
			tmp2=$(mktemp $TMP_TEMPLATE)
			rm $tmp2
			cut_tail $tmp $tmp2 $duration
			rm $tmp
			tmp=$tmp2
			;;
		* )
			echo "Unrecognized argument \'$1\'. Check your input"
			echo Last temprary file: $tmp
			exit 1
			;;
	esac
done

mv $tmp2 "$filename_output"
