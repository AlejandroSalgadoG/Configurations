#!/bin/bash

TIME=$[ $1 * 60 + $2]

while [ 0 -ne $TIME ]; do
    sleep 1
    TIME=$[ $TIME - 1 ]
    echo $TIME
done

killall chrome
poweroff
