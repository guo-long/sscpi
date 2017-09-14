#!/bin/bash

while(true)
do
        echo -n "#"
        sleep 1
done &
BG_PID=$!
sleep 10
kill $BG_PID
