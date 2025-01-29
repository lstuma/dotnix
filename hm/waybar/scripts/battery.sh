#!/usr/bin/env bash

BATTERY=$(battery)
CHARGING=$(echo "$BATTERY" | grep "Charging")
PERCENTAGE=$(echo "$BATTERY" | grep -Eo "[0-9]+")
OUTPUT=""

if [[ $CHARGING ]];
then
  OUTPUT+="<span>󱐋 </span>"
fi

OUTPUT+="<span>$PERCENTAGE<span>%</span></span>"


echo -ne "'{\"text\": \"$OUTPUT\"}'"
