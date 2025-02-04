#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR/utils.sh"

CLICK_FILE="/tmp/wifi_clicked"
if [ "$1" = "click" ]; then
    click-touch $CLICK_FILE
    exit 0
fi

COLOR_DISCONNECTED="#ff5555"
COLOR_WIFI="#ffb86c"
COLOR_ETHER="#ff79c6"
ICON_DISCONNECTED="󰤮"
ICON_WIFI="󰤨"
ICON_ETHER="󱎔"

COLOR_RX="#ed5fda"
COLOR_TX="#ff9e64"
ICON_RX=""
ICON_TX=""


add-speed() {
  # get string representation of speed (upload and download)
  interface=$1

  tx=$(cat /sys/class/net/$interface/statistics/tx_bytes)
  rx=$(cat /sys/class/net/$interface/statistics/rx_bytes)
  txKB=$((tx / 1024))
  rxKB=$((rx / 1024))
  txMB=$((tx / 1024 / 1024))
  rxMB=$((rx / 1024 / 1024))

  txStr="$txKB KB"
  rxStr="$rxKB KB"

  if [ $txKB -gt 4096 ]; then
    txStr="$txMB MB"
  fi
  if [ $rxKB -gt 4096 ]; then
    rxStr="$rxMB MB"
  fi


  output+=" <span color=\\\"$COLOR_RX\\\">$ICON_RX $rxStr</span> <span color=\\\"$COLOR_TX\\\">$ICON_TX $txStr</span>"
}

while true; do
    # get connection data from nmcli
    data=$(nmcli -g "NAME,TYPE,DEVICE" -m tabular conn show --active | grep -v "loopback")
    # only use first connection
    IFS=$'\n' read -rd '' -a conns <<<"$data"
    IFS=":" read -ra conn_data <<<"${conns[0]}"

    # get icon and color
    if [[ ! $data ]]; then
        color=$COLOR_DISCONNECTED
        icon=$ICON_DISCONNECTED
        output="No connection"
    elif [[ $(echo ${conn_data[1]} | grep "wireless") ]]; then
        color=$COLOR_WIFI
        icon=$ICON_WIFI
        output="${conn_data[0]}"
    else
        color=$COLOR_ETHER
        icon=$ICON_ETHER
        output="${conn_data[0]}"
    fi

    # on click shortly change text to network+speed
    if [ -f "$CLICK_FILE" ]; then
        add-speed ${conn_data[2]}
    fi

    text="<span color=\\\"$color\\\">$icon $output</span>"
    output "$text" "$text"
    sleep 0.5
done
