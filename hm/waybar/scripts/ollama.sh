#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR/utils.sh"

get-status-openwebui() {
    # get status of openwebui
    stat="$(systemctl is-active open-webui.service)"
    echo "$stat"
}

get-status-ollama() {
    # get status of ollama
    stat="$(systemctl is-active ollama.service)"
    echo "$stat"
}

get-status-automatic() {
    # get status of automatic1111
    stat="$(systemctl is-active automatic.service)"
    echo "$stat"
}

get-status() {
    # get status of the service
    ollama_stat="$(get-status-ollama)"
    openwebui_stat="$(get-status-openwebui)"
    if [ "$ollama_stat" = "$openwebui_stat" ]; then
        echo "$ollama_stat"
        return
    fi
    echo "unknown"
}

if [ "$1" = "click" ]; then
    if [ "$(get-status)" = "active" ]; then
        firefox "http://localhost:8080/"
    else
        systemctl start open-webui.service
        systemctl start ollama.service
    fi
    exit 0
fi

GREEN="#41d992"
YELLOW="#f5ec6e"
ORANGE="#ff9e64"
RED="#ff7a93"
PURPLE="#bb9af7"
LIGHT_GREEN="#b9f27c"
LIGHT_BLUE="#7da6ff"

ICON_OFF="󱚡 "
ICON_ON="󱚣 "
ICON_UNKNOWN="󱚟 "

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

    text="<span color=\\\"$color\\\">$icon</span>"

    tooltip="Ollama: $(get-status-ollama), OpenWebUI: $(get-status-openwebui), Automatic: $(get-status-automatic)"

    output "$text" "$tooltip"
    sleep 0.5
done
