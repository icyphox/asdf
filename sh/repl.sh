#!/usr/bin/env bash

show_help() {
	echo "Usage: repl [options] command"
	echo ""
	echo "Options:"
	echo "    --help    Display this message"
	echo "    --stdin   Pipe input to command's STDIN"
	echo ""
	echo "Examples:"
	echo "    $ repl git"
	echo "    $ repl gcc"
}

if [ $# -lt 1 ]
then
	show_help
	exit
else
	CMD=$1
fi

STORAGE="$HOME/.repl"
if [ ! -d "$STORAGE" ]
then
	mkdir "$STORAGE"
fi

if [ ! -e "$STORAGE/$1.hist" ]
then
	touch "$STORAGE/$1.hist"
fi

if [ -x "$(command -v rlwrap)" ] && [ -z "$USING_RLWRAP" ]
then
	export USING_RLWRAP=1
	rlargs="-H $STORAGE/$1.hist"
	$(rlwrap $rlargs $0 $CMD)
	exit
fi

echo "Ctrl+C to quit"
while true
do
	read -p "$CMD% " INPUT
	OUTPUT=$(eval "$CMD $INPUT")
	echo "$OUTPUT"
done
