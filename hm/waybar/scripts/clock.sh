#!/usr/bin/env bash

TEMP_CLICK_FILE="/tmp/clock_clicked"

if [ "$1" = "click" ]; then
    touch "$TEMP_CLICK_FILE"
    exit 0
fi

GREEN="#41d992"
WHITE="#f8f8f2"
YELLOW="#f5ec6e"

ICON="󰥔"
COLOR="$WHITE"
TOOLTIP_ICON="󰥔"
TOOLTIP_COLOR="$WHITE"

output() {
    echo "{\"text\":\"$TEXT\", \"tooltip\": \"$TOOLTIP_TEXT\"}"
}

while true; do
    TIME=$(date +"%H:%M:%S")
    DATE=$(date +"%A %d %B %Y")

    TEXT="$ICON $TIME"
    TOOLTIP_TEXT="$TOOLTIP_ICON $TIME\n$DATE"

    # on click shortly change text to time+date
    if [ -f "$TEMP_CLICK_FILE" ]; then
        TEXT="$ICON $TIME $DATE"
        output
        sleep 10
        #rm "$TEMP_CLICK_FILE"
    else
        output
        sleep 0.5
    fi
done
