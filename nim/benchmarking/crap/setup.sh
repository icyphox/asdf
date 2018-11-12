#!/usr/bin/env bash

mkdir files
cd files
for i in {1..100000}
do
	touch $i.md
	echo "# lmao" > $i.md
done
