#!/usr/bin/env bash

BATTERY=$(battery)
CHARGING=$(echo "$BATTERY" | grep "Charging")
PERCENTAGE=$(echo "$BATTERY" | grep -Eo "[0-9]+")
OUTPUT=""

if [[ $CHARGING ]];
then
  OUTPUT+="<span class=\"battery-charge-icon\">󱐋 </span>"
fi

OUTPUT+="<span class=\"battery-charge-number\">$PERCENTAGE<span class=\"batter-charge-percent\">%</span></span>"


echo -ne "'{\"text\": \"$OUTPUT\"}'"
