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

COLOR_RX="#41d992"
COLOR_TX="#ed5fda"
ICON_RX=""
ICON_TX=""


add-speed() {
  # get string representation of speed (upload and download)
  interface=$1

  # get rx and tx speed in bytes per second
  rxStart=$(cat /sys/class/net/$interface/statistics/rx_bytes)
  txStart=$(cat /sys/class/net/$interface/statistics/tx_bytes)
  sleep 0.5
  rxEnd=$(cat /sys/class/net/$interface/statistics/rx_bytes)
  txEnd=$(cat /sys/class/net/$interface/statistics/tx_bytes)

  rx=$(((rxEnd - rxStart) * 2))
  tx=$(((txEnd - txStart) * 2))

  txKB=$((tx / 1024))
  rxKB=$((rx / 1024))
  txMB=$((tx / 1024 / 1024))
  rxMB=$((rx / 1024 / 1024))

  txStr="$txKB KB"
  rxStr="$rxKB KB"

  if [ $txMB -gt 5 ]; then
    txStr="$txMB MB"
  fi
  if [ $rxMB -gt 5 ]; then
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
        # remove click file (deactivated since I like to keep the speed display on sometimes)
        #click-untouch $CLICK_FILE 5
    fi

    text="<span color=\\\"$color\\\">$icon $output</span>"
    output "$text" "$text"
    sleep 0.5
done
