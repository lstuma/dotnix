#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
LLMUTILS_PATH="$SCRIPT_DIR/llmutils.sh"
source "$LLMUTILS_PATH"
LLMUTILS_EXEC="/usr/bin/env bash $LLMUTILS_PATH"


# click event
if [ "$1" = "click" ]; then
    if [ "$(llm health overall)" = "active" ]; then
        # open the webui
        firefox "http://localhost:8080/"
    else
        notify-error "error" "ollama is not active" "start the service first"
    fi
    exit 0
elif [ "$1" = "right-click" ]; then
    # use yad to show a menu
    # show status of all services, buttons to start/stop dependent on status
    options=()
    for service in "${SERVICES[@]}"; do
        status=$(_llm_status $service)
        if [ "$status" = "active" ]; then
            color="$GREEN"
        elif [ "$status" = "inactive" ]; then
            color="$RED"
        else
            color="$YELLOW"
        fi
        options+=("$service $status")
    done

    chosen=$(yad --title="Ollama" --button=yad-cancel:1 --button="Toggle Status":0 --list --column="Service" --column="Status" ${options[@]})
    # toggle service status
    # get the service name (split at |)
    service=$(echo $chosen | cut -d'|' -f1)
    if [ -z "$service" ]; then
        exit 0
    fi
    llm docker toggle $service
    exit 0
fi

GREEN="#41d992"
YELLOW="#f5ec6e"
ORANGE="#ff9e64"
RED="#ff7a93"
PURPLE="#bb9af7"
LIGHT_GREEN="#b9f27c"
LIGHT_BLUE="#7da6ff"

ICON_OFF="󱚧 "
ICON_ON="󱚣 "
ICON_UNKNOWN="󱚢 "
ICON_ERROR=" "

COLOR_OFF="$RED"
COLOR_ON="$GREEN"
COLOR_UNKNOWN="$YELLOW"
COLOR_ERROR="$ORANGE"

while true; do
    ai_status="$(llm status 'overall')"
    text=""
    if [ "$ai_status" = "active" ]; then
        icon="$ICON_ON"
        color="$COLOR_ON"
    elif [ "$ai_status" = "inactive" ]; then
        icon="$ICON_OFF"
        color="$COLOR_OFF"
    elif [ "$ai_status" = "unknown" ]; then
        icon="$ICON_UNKNOWN"
        color="$COLOR_UNKNOWN"
    else
        icon="$ICON_ERROR"
        text="$ai_status"
        color="$COLOR_ERROR"
        notify-error "error" "unknown status (llm)" "$ai_status"
    fi

    out="<span color=\\\"$color\\\">$icon$text</span>"
    tooltip="$(llm status 'all')"

    output "$out" "$tooltip"
    sleep 0.5
done
