#!/usr/bin/env bash

notify-info() {
    # send a notification
    notify-send -i "$1" "$2" "$3"
}

notify-error() {
    # send a notification
    notify-send -i "$1" "$2" "$3" -u critical
}

notify-warning() {
    # send a notification
    notify-send -i "$1" "$2" "$3" -u normal
}

click-touch() {
    # create or delete file on click
    file=$1
    if [ -f "$file" ]; then
        rm "$file"
    else
        # ensure the file is empty
        echo -n "" > $file
    fi
}

click-untouch() {
    # create or delete file on click
    file=$1
    timeout=$2
    # if theres is already an id in the file, do nothing
    if [ $(cat $file) ]; then
        return
    fi
    (echo "$BASHPID" > $file && sleep $timeout && if [ $(cat $file) = $BASHPID ]; then rm $file; fi) &
}

output() {
    text=$1
    tooltip=$2
    # waybar output in json format
    echo "{\"text\":\"$text\", \"tooltip\": \"$tooltip\"}"
}

rm-exist() {
    # remove file if exists
    file=$1
    if [ -f "$file" ]; then
        rm "$file"
    fi
}
