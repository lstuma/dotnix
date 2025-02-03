#!/usr/bin/env bash
COLOR_WIFI="#ffb86c"
COLOR_ETHER="#ff79c6"

# data in colon separated with format: NAME:TYPE\n
data=$(nmcli -g "NAME,TYPE" -m tabular conn show --active)
if [[ $1 ]] then
  data=$(echo $data | grep -v "$0")
fi
# parse into array
IFS=$'\n' read -rd '' -a conns <<<"$data"
for conn in "${conns[@]}"
do
  IFS=":" read -ra conn_data <<<"$conn"
  WIRELESS="$(echo ${conn_data[1]} | grep 'wireless')"
  echo -ne "<span>"
  if [[ $WIRELESS ]] then
    echo -ne "<span color=\"$COLOR_WIFI\">󰤨 </span>"
  else
    echo -ne "<span color=\"$COLOR_ETHER\">󱎔 </span>"
  fi
  echo "${conn_data[0]}</span>"
done
