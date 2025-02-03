#!/usr/bin/env bash

if [ "$1" = "click" ]; then
    touch "/tmp/clock_clicked"
    exit 0
fi

GREEN="#41d992"
WHITE="#f8f8f2"
YELLOW="#f5ec6e"

ICON="󰥔"
COLOR="$WHITE"
TOOLTIP_ICON="󰥔"
TOOLTIP_COLOR="$WHITE"

TEMP_CLICK_FILE="/tmp/clock_clicked"

while true; do
    TIME=$(date +"%H:%M:%S")
    DATE=$(date +"%A %d %B %Y")

    TEXT="$ICON $TIME"
    TOOLTIP_TEXT="$TOOLTIP_ICON $TIME\n$DATE"

    # on click shortly change text to time+date
    if [ -f "$TEMP_CLICK_FILE" ]; then
        TEXT="$ICON $TIME $DATE"
        rm "$TEMP_CLICK_FILE"
        DELAY="10"
    else
        DELAY="0.5"
    fi

    # format the output
    echo "{\"text\":\"$TEXT\", \"tooltip\": \"$TOOLTIP_TEXT\"}"
    sleep "$DELAY"
done
