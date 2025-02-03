#!/usr/bin/env bash

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

    DELAY="0.5"

    # on click shortly change text to time+date
    if [ -f "$TEMP_CLICK_FILE" ]; then
        TEXT="$ICON $TIME $DATE"
        rm "$TEMP_CLICK_FILE"
    fi

    # format the output
    echo "{\"text\":\"$TEXT\", \"tooltip\": \"$TOOLTIP_TEXT\"}"
    sleep "$DELAY"
done
