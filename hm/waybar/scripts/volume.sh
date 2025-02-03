#!/usr/bin/env bash

RED="#8be9fd"
PURPLE="#8be9fd"
MAGENTA="#8be9fd"

while true; do
    VOLUME=$(pamixer --get-volume)
    COLOR="#bd93f9";

    if [[ "$(pamixer --get-mute)" =~ "true"  ]] then
        OUTPUT="󰝟"
        COLOR="$RED"
        else
        if [[ "$VOLUME" -eq "0" ]] then
            COLOR="$MAGENTA"
            OUTPUT="󰕿"
        elif [[ "$VOLUME" -lt "50" ]] then
            COLOR="$PURPLE"
            OUTPUT="󰖀"
        else
            COLOR="$PURPLE"
            OUTPUT="󰕾"
        fi
    fi
    OUTPUT+=" $VOLUME%"

    echo "<span color=\"$COLOR\">$OUTPUT</span>"
done
