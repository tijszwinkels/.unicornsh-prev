#!/bin/bash
LASTOUTPUTLINES=${1:-50}

# Looks like sgpt already does this
# echo "shell: $SHELL"
# echo "uname: `uname`"
# echo "pwd: `pwd`"
# echo ""

echo "The last command I executed was (including shell prompt):"
echo '```'
# Use tail -r to reverse the lines, grep to find the prompt, and process the output
tail -r $SCRIPT | grep --max-count=2 -e "^🦄" | tail -n 1
echo '```'
echo ""

echo "$LASTOUTPUTLINES last lines of output of last executed command:"
echo '```'
tail -r $SCRIPT | gsed 's/[\x00-\x08\x0B\x0C\x0E-\x1F\x7F]//g' | grep --max-count=2 -B 10000 -e "^🦄" | tail -r | grep --invert-match -e "^🦄" | tail -n $LASTOUTPUTLINES
echo '```'
echo ""

