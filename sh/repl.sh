#!/usr/bin/env bash

if [ $# -lt 1 ]
then
	exit
else
	CMD=$1
fi

while true
do
	read -p "$CMD>> " INPUT
	OUTPUT=$(eval "$CMD $INPUT")
	echo "$OUTPUT"
done
