#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR/utils.sh"

CLICK_FILE="/tmp/battery_clicked"
if [ "$1" = "click" ]; then
    click-touch $CLICK_FILE
    exit 0
elif [ "$1" = "right-click" ]; then
    toggle-low-power-mode
    exit 0
fi

GREEN="#41d992"
YELLOW="#f5ec6e"
ORANGE="#ff9e64"
RED="#ff7a93"
PURPLE="#bb9af7"
LIGHT_GREEN="#b9f27c"
LIGHT_BLUE="#7da6ff"

while true; do

    BATTERY=$(battery)
    CHARGING=$(echo "$BATTERY" | grep "Charging")
    LOW_POWER_MODE=$(is-low-power-mode | grep "true")
    FULL=$(echo "$BATTERY" | grep "Full")
    CHARGE=$(echo "$BATTERY" | grep -Eo "[0-9]+")
    TIME_REMAINING=$(acpi -b | grep -Eo "[0-9][0-9]:[0-9][0-9]:[0-9][0-9]")
    if [[ -z "$TIME_REMAINING" ]]; then
        TIME_REMAINING="lots of time"
    fi
    COLOR="$RED"
    ICON="? "

    if [[ $LOW_POWER_MODE ]] then
        ICON="󰂊 "
        COLOR="$YELLOW"
    elif [[ $FULL ]] then
        ICON=" "
        COLOR="$GREEN"
    elif [[ $CHARGING ]] then
        ICON="󱐋 "
        COLOR="$LIGHT_BLUE"
    else
        if [[ "$CHARGE" -lt "20" ]] then
            ICON=" "
            COLOR="$RED"
        elif [[ "$CHARGE" -lt "50" ]] then
            ICON="󰁽 "
            COLOR="$ORANGE"
        elif [[ "$CHARGE" -lt "80" ]] then
            ICON="󰂀 "
            COLOR="$YELLOW"
        else
            ICON="󱈑 "
            COLOR="$LIGHT_GREEN"
        fi
    fi

    TEXT="<span color=\\\"$COLOR\\\">$ICON$CHARGE%</span>"
    TOOLTIP_TEXT="$BATTERY% $TIME_REMAINING"

    if [ -f "$CLICK_FILE" ]; then
        TEXT="<span color=\\\"$COLOR\\\">$TIME_REMAINING remaining $ICON$CHARGE%</span>"
        click-untouch $CLICK_FILE 10
    fi
    output "$TEXT" "$TOOLTIP_TEXT"
    sleep 0.3
done
