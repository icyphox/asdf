#!/bin/sh

FILE=$1

while true; do
   lsof "${FILE}"
done > /tmp/fileusers.log
