#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR/utils.sh"

TEMP_CLICK_FILE="/tmp/clock_clicked"
if [ "$1" = "click" ]; then
    click_touch $TEMP_CLICK_FILE
    exit 0
fi

GREEN="#41d992"
WHITE="#f8f8f2"
YELLOW="#f5ec6e"

ICON="󰥔"
COLOR="$WHITE"
TOOLTIP_ICON="󰥔"
TOOLTIP_COLOR="$WHITE"

while true; do
    TIME=$(date +"%H:%M:%S")
    DATE=$(date +"%A %d %B %Y")

    TEXT="$ICON $TIME   "
    TOOLTIP_TEXT="$TOOLTIP_ICON $TIME\n$DATE"

    # on click shortly change text to time+date
    if [ -f "$TEMP_CLICK_FILE" ]; then
        TEXT="$ICON $TIME $DATE"
        output "$TEXT" "$TOOLTIP_TEXT"
        sleepwatch "$TEMP_CLICK_FILE" 10
        #rm-exist "$TEMP_CLICK_FILE"
    else
        output "$TEXT" "$TOOLTIP_TEXT"
        sleepwatch "$TEMP_CLICK_FILE" 0.8
    fi
done
