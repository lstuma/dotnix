#!/usr/bin/env bash

output() {
    text=$1
    tooltip=$2
    # waybar output in json format
    echo "{\"text\":\"$text\", \"tooltip\": \"$tooltip\"}"
}

sleepwatch() {
    # sleep but break if file is created or deleted
    file=$1
    time=$((time * 10))
    if [ ! -f "$file" ]; then
        state="deleted"
    else
        state="created"
    fi
    waited=0
    while [ $waited -lt $time ]; do
        if [ ! -f "$file" ] && [ "$state" = "created" ]; then
            break
        elif [ -f "$file" ] && [ "$state" = "deleted" ]; then
            break
        fi
        sleep 0.1
        waited=$(($waited + 1))
    done
}
