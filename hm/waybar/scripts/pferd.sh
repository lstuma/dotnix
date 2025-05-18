#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR/utils.sh"
TEMP_FILE="/tmp/pferd.lock"
INFO_FILE="$HOME/.pferd.last-update.info"

pferd-force() {
    touch "$TEMP_FILE"
    pferd
    echo $(date +%s) > "$INFO_FILE"
    rm "$TEMP_FILE"
}

pferd-run() {
    # check if the lock file exists
    if [ -f "$TEMP_FILE" ]; then
        # if it exists, do nothing
        exit 0
    fi
    pferd-force
}

pferd-status() {
    if [ -f "$TEMP_FILE" ]; then
        # if it exists, do nothing
        echo "running"
    else
        # if it does not exist, do nothing
        now=$(date +%s)
        if [ ! -f "$INFO_FILE" ]; then
            echo "old"
            return
        fi
        then=$(cat "$INFO_FILE")
        delta=$((now - then))
        if [ $delta -lt 2400 ]; then
            # delta is less than 40 minutes
            echo "fresh"
        elif [ $delta -lt 86400 ]; then
            # delta is less than 1 day
            echo "stale"
        else
            # if the delta is greater than 120 seconds, do nothing
            echo "old"
        fi
        return
    fi
}

pferd-waybar() {
    PFERD_ICON=""
    UPDATE_ICON="󰚰"
    ERROR_ICON=""

    GREEN="#41d992"
    YELLOW="#f5ec6e"
    ORANGE="#ff9e64"
    RED="#ff7a93"
    PURPLE="#bb9af7"

    while true; do
        status=$(pferd-status)
        out="$ERROR_ICON"
        color="$RED"
        case "$status" in
            "running")
                out="$UPDATE_ICON"
                color="$YELLOW"
                ;;
            "fresh")
                out="$PFERD_ICON"
                color="$GREEN"
                ;;
            "stale")
                out="$PFERD_ICON"
                color="$ORANGE"
                ;;
            "old")
                out="$PFERD_ICON"
                color="$RED"
                ;;
        esac
        out="<span color=\\\"$color\\\">$out</span>"
        tooltip="Pferd is $status"
        output "$out" "$tooltip"
        sleep 0.4
    done
}

case "$1" in

  "force")
    pferd-force
    ;;

  "status")
    pferd-status
    ;;

  "waybar")
    pferd-waybar
    ;;

  "run")
    pferd-run
    ;;

  *)
    exit -1;
    ;;
esac
