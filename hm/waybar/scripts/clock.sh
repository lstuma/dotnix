#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR/utils.sh"

CLICK_FILE="/tmp/clock_clicked"
if [ "$1" = "click" ]; then
    click-touch $CLICK_FILE
    exit 0
fi

GREEN="#41d992"
WHITE="#f8f8f2"
YELLOW="#f5ec6e"

ICON=""
COLOR="$WHITE"
TOOLTIP_ICON="$ICON"
TOOLTIP_COLOR="$COLOR"

while true; do
    TIME=$(date +"%H:%M:%S")
    DATE=$(date +"%A %d %B %Y")

    TEXT="$ICON $TIME   "
    TOOLTIP_TEXT="$TOOLTIP_ICON $TIME\n$DATE"

    # on click shortly change text to time+date
    if [ -f "$CLICK_FILE" ]; then
        TEXT="$ICON $TIME $DATE"
        click-untouch $CLICK_FILE 5
    fi
    output "$TEXT" "$TOOLTIP_TEXT"
    sleep 0.2
done
