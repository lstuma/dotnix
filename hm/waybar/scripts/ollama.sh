#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR/utils.sh"

get-docker-status() {
    # get status of a docker container
    stat="$(docker ps )"
    echo "$stat"
}

get-status-openwebui() {
    # get status of openwebui
    stat="$(a)"
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

DOCKER_OLLAMA="ollama/ollama"
DOCKER_WEBUI=

start-openwebui() {
    # build open-webui (if non-existent) and start the container
    docker run -d -p 3000:8080 \
        --add-host=host.docker.internal:host-gateway \
        -e AUTOMATIC1111_BASE_URL=http://host.docker.internal:7860/ \
        -e ENABLE_IMAGE_GENERATION=True \
        -v open-webui:/app/backend/data \
        --name open-webui \
        --restart always ghcr.io/open-webui/open-webui:main || \
    docker start open-webui
}

kill-openwebui() {
    docker stop open-webui
}

start-ollama() {
    # build ollama (if non-existent) and start the container
    docker run -d -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama || \
    docker start ollama
}

kill-ollama() {
    docker stop ollama
}

start-automatic() {
    # build automatic1111 (if non-existent) and start the container
    docker run -d -p 7860:7860 \
        --add-host=host.docker.internal:host-gateway \
        -v automatic1111:/app/backend/data \
        --name automatic1111 \
        --restart always ghcr.io/automatic1111/automatic1111:main || \
    docker start automatic1111
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

ICON_OFF="󱚧 "
ICON_ON="󱚣 "
ICON_UNKNOWN="󱚢 "

COLOR_OFF="$RED"
COLOR_ON="$GREEN"
COLOR_UNKNOWN="$YELLOW"

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
