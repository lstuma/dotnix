#!/usr/bin/env bash

GREEN="#41d992"
WHITE="#f8f8f2"
YELLOW="#f5ec6e"

TIME=$(date +"%H:%M:%S")
DATE=$(date +"%A %d %B %Y")

ICON="󰥔"
COLOR="$WHITE"
TEXT="$ICON $TIME"

TOOLTIP_ICON="󰥔"
TOOLTIP_COLOR="$WHITE"
TOOLTIP_TEXT="$TOOLTIP_ICON $TIME\n$DATE"

# on click shortly change text to time+date
read -r line
if [[ "$line" ]]; then
    TEXT="$ICON $TIME $DATE"
fi

# format the output
echo "{\"text\":\"$TEXT\", \"tooltip\": \"$TOOLTIP_TEXT\"}"
