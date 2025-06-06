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

is-low-power-mode() {
    # check if low power mode is enabled
    if [ -f "$LOW_POWER_MODE_FILE" ]; then
        return 0  # true
    else
        return 1  # false
    fi
}

LOW_POWER_MODE_FILE="/tmp/low_power_mode"
toggle-low-power-mode() {
    if [ -f "$LOW_POWER_MODE_FILE" ]; then
        rm "$LOW_POWER_MODE_FILE"
        notify-info "Low Power Mode" "Disabled" "Your system is now in normal mode."
    else
        touch "$LOW_POWER_MODE_FILE"
        notify-warning "Low Power Mode" "Enabled" "Your system is now in low power mode."
    fi
}
