#!/usr/bin/env bash

BATTERY=$(battery)
CHARGING=$(echo "$BATTERY" | grep "Charging")
PERCENTAGE=$(echo "$BATTERY" | grep -Eo "[0-9]+")

OUTPUT="<spann color=\"#ff7a93\">"
if [[ $CHARGING ]];
then
  OUTPUT="<span color=\"#7da6ff\">󱐋 "
fi

OUTPUT+="$PERCENTAGE<span>%</span></span>"


echo -ne "$OUTPUT"
