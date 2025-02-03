#!/usr/bin/env bash

click_touch() {
    # create or delete file on click
    file=$1
    if [ -f "$file" ]; then
        echo "deleting $file"
        rm "$file"
    else
        echo "creating $file"
        touch "$file"
    fi
}

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
    if [ -f "$file" ]; then
        state="created"
    else
        state="deleted"
    fi
    waited=0
    while [ $waited -lt $time ]; do
        if [ -f "$file" ] && [ "$state" = "deleted" ]; then
            break
        elif [ ! -f "$file" ] && [ "$state" = "created" ]; then
            break
        fi
        sleep 0.1
        waited=$(($waited + 1))
    done
}

rm-exist() {
    # remove file if exists
    file=$1
    if [ -f "$file" ]; then
        rm "$file"
    fi
}
