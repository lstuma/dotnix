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
        rm "$TEMP_CLICK_FILE"
        output
        sleep 10
    else
        output
        sleep 0.5
    fi
done
