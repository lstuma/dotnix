#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR/utils.sh"

CLICK_FILE="/tmp/clock_clicked"
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


get-speed() {
  # get string representation of speed (upload and download)
  interface=$1

  tx=$(cat /sys/class/net/$interface/statistics/tx_bytes)
  rx=$(cat /sys/class/net/$interface/statistics/rx_bytes)
  txMB=$((tx / 1024 / 1024))
  rxMB=$((rx / 1024 / 1024))

  return "$ICON_RX $rxMB MB/s $ICON_TX $txMB MB/s"
}

while true; do
    # get connection data from nmcli
    data=$(nmcli -g "NAME,TYPE" -m tabular conn show --active)
    if [[ $1 ]]; then
        data=$(echo $data | grep -v "$0")
    fi
    # only use first connection
    IFS=$'\n' read -rd '' -a conns <<<"$data"
    IFS=":" read -ra conn_data <<<"$conn[0]"

    # get icon and color
    if [[ ${#yconn_data[@]} -eq 0 ]]; then
        color=$COLOR_DISCONNECTED
        icon=$ICON_DISCONNECTED
        output="No connection"
    elif [[ $(echo ${conn_data[1]} | grep "wireless") ]]; then
        color=$COLOR_WIFI
        icon=$ICON_WIFI
        output=${conn_data[0]}
    else
        color=$COLOR_ETHER
        icon=$ICON_ETHER
        output=${conn_data[0]}
    fi

    # on click shortly change text to network+speed
    if [ -f "$CLICK_FILE" ]; then
        speed=$(get-speed ${conn_data[0]})
        output+=" $speed"
    fi

    text="<span color=\\\"$color\\\">$icon $output</span>"
    output "$text" "$text"
    sleep 0.5
done
