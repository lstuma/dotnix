#!/usr/bin/env bash

BATTERY=$(battery)
CHARGING=$(echo "$BATTERY" | grep "Charging")
FULL=$(echo "$BATTERY" | grep "Full")
PERCENTAGE=$(echo "$BATTERY" | grep -Eo "[0-9]+")

OUTPUT="<span color=\"#ff7a93\">"
if [[ $CHARGING ]];
then
  OUTPUT="<span color=\"#7da6ff\">󱐋 "
fi
if [[ $FULL ]];
then
  OUTPUT="<span color=\"#b9f27c\"> "
fi

OUTPUT+="$PERCENTAGE<span>%</span></span>"


echo -ne "$OUTPUT"
