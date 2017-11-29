#!/bin/bash

DEFAULT=/lib:/lib64:/usr/lib
LIB1=$LD_LIBARRY_PATH
LIB2=$LIBRARY_PATH

EXAMPLE="$DEFAULT:$LIB1:$LIB2"

ARRAY=$(echo $EXAMPLE | tr ":" "\n")

ARRAY_UNIQUE=$(echo "${ARRAY[@]}" | sort -u)

for i in $ARRAY_UNIQUE; do
    ls $i | grep $1 | sed "s@^@$i/@"
done
