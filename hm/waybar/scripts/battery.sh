#!/usr/bin/env bash

GREEN="#41d992"
YELLOW="#f5ec6e"
ORANGE="#ff9e64"
RED="#ff7a93"
PURPLE="#bb9af7"
LIGHT_GREEN="#b9f27c"
LIGHT_BLUE="#7da6ff"

BATTERY=$(battery)
CHARGING=$(echo "$BATTERY" | grep "Charging")
FULL=$(echo "$BATTERY" | grep "Full")
CHARGE=$(echo "$BATTERY" | grep -Eo "[0-9]+")
COLOR="$RED"
ICON="?"


if [[ $FULL ]] then
    ICON=""
    COLOR="$GREEN"
elif [[ $CHARGING ]] then
    ICON="󱐋"
    COLOR="$LIGHT_BLUE"
else
    if [[ "$CHARGE" -lt "20" ]] then
        ICON=""
        COLOR="$RED"
    elif [[ "$CHARGE" -lt "50" ]] then
        ICON="󰁽"
        COLOR="$ORANGE"
    elif [[ "$CHARGE" -lt "80" ]] then
        ICON="󰂀"
        COLOR="$YELLOW"
    else
        ICON="󱈑"
        COLOR="$LIGHT_GREEN"
    fi
fi

echo "<span color=\"$COLOR\">$ICON$CHARGE%</span>"
