#!/usr/bin/env bash

BATTERY=$(battery)
CHARGING=$(echo "$BATTERY" | grep "Charging")
PERCENTAGE=$(echo "$BATTERY" | grep -Eo "[0-9]+")

if [[ $CHARGING ]];
then
  echo -en "<span class=\"battery-charge-icon\">󱐋 </span>"
fi

echo -ne "<span class=\"battery-charge-number\">$PERCENTAGE<span class=\"batter-charge-percent\">%</span></span>"
