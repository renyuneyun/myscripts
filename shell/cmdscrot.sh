#!/bin/sh

# Take "screenshots" of shell outputs even for long outputs that doesn't fit in one screen.
# Replys on `script`, `ansi2html` and `CutyCapt`.

PALETTE="tango"
TMP_DIR="/tmp"
TYPESCRIPT_FILE=${TMP_DIR}"/typescript"
HTML_FILE=${TMP_DIR}"/output.html"
IMG_FILE=${TMP_DIR}"/output.png"

# Record output
script -q $TYPESCRIPT_FILE

# Convert shell output to HTML
ansi2html --bg=dark --palette=$PALETTE < $TYPESCRIPT_FILE > $HTML_FILE
rm $TYPESCRIPT_FILE &

# Convert HTML to image
CutyCapt --url=file://$HTML_FILE --out=$IMG_FILE --zoom-factor=2 --zoom-text-only=on
rm $HTML_FILE &

echo Image generated at $IMG_FILE

