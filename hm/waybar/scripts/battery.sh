#!/usr/bin/env bash

BATTERY=$(battery)
CHARGING=$(echo "$BATTERY" | grep "Charging")
FULL=$(echo "$BATTERY" | grep "Full")
PERCENTAGE=$(echo "$BATTERY" | grep -Eo "[0-9]+")

if [[ $CHARGING ]];
then
  OUTPUT="<span color=\"#7da6ff\">󱐋"
elif [[ $FULL ]];
then
  OUTPUT="<span color=\"#b9f27c\"> "
else
  OUTPUT="<span color=\"#ff7a93\"> "
fi

OUTPUT+="$PERCENTAGE<span>%</span></span>"


echo -ne "$OUTPUT"
