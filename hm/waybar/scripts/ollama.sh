#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR/utils.sh"

get-status() {
    # get status of the service
    ollama_stat="$(systemctl is-active open-webui.service)"
    openwebui_stat="$(systemctl is-active open-webui.service)"
    if [ "$ollama_stat" = "$openwebui_stat" ]; then
        echo "$ollama_stat"
        return
    fi
    echo "unknown"
}

if [ "$1" = "click" ]; then
    click-touch /tmp/ollama_clicked
    exit 0
fi

GREEN="#41d992"
YELLOW="#f5ec6e"
ORANGE="#ff9e64"
RED="#ff7a93"
PURPLE="#bb9af7"
LIGHT_GREEN="#b9f27c"
LIGHT_BLUE="#7da6ff"

ICON_OFF="󱚡"
ICON_ON="󱚣"
ICON_UNKNOWN="󱚟"

COLOR_OFF="$RED"
COLOR_ON="$GREEN"
COLOR_UNKNOWN="$PURPLE"

while true; do
    ai_status="$(get-status)"
    if [ "$ai_status" = "active" ]; then
        icon="$ICON_ON"
        color="$COLOR_ON"
    elif [ "$ai_status" = "inactive" ]; then
        icon="$ICON_OFF"
        color="$COLOR_OFF"
    else
        icon="$ICON_UNKNOWN"
        color="$COLOR_UNKNOWN"
    fi

    text="<span color=\\\"$color\\\">$icon </span>"
    output "$text" "$text"
    sleep 0.5
done
