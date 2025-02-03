#!/usr/bin/env bash

click-touch() {
    # create or delete file on click
    file=$1
    if [ -f "$file" ]; then
        echo "deleting $file"
        rm "$file"
    else
        echo "creating $file"
        # ensure the file is empty
        echo -n "" > $file
    fi
}

click-untouch() {
    # create or delete file on click
    file=$1
    timeout=$2
    # if theres is already an id in the file, do notthing
    if [ -f "$file" ]; then
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

sleepwatch() {
    # sleep but break if a certain file is deleted
    file=$1
    time=$((time * 10))
    waited=0
    while [ $waited -lt $time ]; do
        if [ ! -f "$file" ]; then
            echo "file $file deleted" >> /tmp/waybar.log
            return
        fi
        echo "waiting for $file" >> /tmp/waybar.log
        sleep 0.1
        waited=$(($waited + 1))
    done
    echo "timeout" >> /tmp/waybar.log
}

sleepwatch-rm() {
    # sleep but break if file is created or deleted and remove file at the end
    sleepwatch $1 $2
    rm-exist $1
}

rm-exist() {
    # remove file if exists
    file=$1
    if [ -f "$file" ]; then
        rm "$file"
    fi
}
