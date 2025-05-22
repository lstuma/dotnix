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

pferd-delta() {
    # if it does not exist, do nothing
    now=$(date +%s)
    if [ ! -f "$INFO_FILE" ]; then
        echo "old"
        return
    fi
    then=$(cat "$INFO_FILE")
    delta=$((now - then))
    echo $delta
}

pferd-stale-percentage() {
    time=$(pferd-delta)
    if [ $time -ew "old" ]; then
        echo 100
        return
    fi
    percentage=(($time / 86400))
    echo $percentage
}

pferd-time-since() {
    # if it does not exist, do nothing
    if [ ! -f "$INFO_FILE" ]; then
        echo "never happened"
        return
    fi
    then=$(pferd-delta)
    if [ $then -lt 60 ]; then
        echo "$then seconds ago"
    elif [ $then -lt 3600 ]; then
        echo "$((then / 60)) minutes ago"
    elif [ $then -lt 86400 ]; then
        echo "$((then / 3600)) hours ago"
    else
        echo "$((then / 86400)) days ago"
    fi
}

pferd-status() {
    if [ -f "$TEMP_FILE" ]; then
        # if it exists, do nothing
        echo "running"
    else
        delta=$(pferd-delta)
        if [ $delta -lt 1200 ]; then
            # delta is less than 20 minutes
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
    GREEN_2="#41d84b"
    GREEN_3="#76d841"
    GREEN_4="#97d841"
    YELLOW="#f5ec6e"
    ORANGE="#ff9e64"
    RED="#ff7a93"
    PURPLE="#bb9af7"
    BLUE="#7da6ff"

    while true; do
        status=$(pferd-status)
        out="$ERROR_ICON"
        color="$RED"
        case "$status" in
            "running")
                out="$UPDATE_ICON"
                color="$BLUE"
                ;;
            "fresh")
                out="$PFERD_ICON"
                color="$GREEN"
                percentage=$(pferd-stale-percentage)
                color="$($SCRIPT_DIR/color-mix.sh $GREEN $YELLOW $percentage)"
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
        tooltip="Last update $(pferd-time-since) ($status)"
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
