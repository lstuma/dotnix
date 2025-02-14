#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR/utils.sh"

# names of the docker containers
DOCKER_OLLAMA="ollama"
DOCKER_WEBUI="open-webui"
DOCKER_AUTOMATIC="automatic1111"

# check if a specific docker container is active
docker-get-status() {
    # get status of a docker container
    stat="$(docker ps -q -f name=\"$1\")"
    if [ -z "$stat" ]; then
        echo "inactive"
    else
        echo "active"
    fi
}

llm-status() {
    if [ "$1" = "ollama" ]; then
        echo "$(docker-get-status $DOCKER_OLLAMA)"
    elif [ "$1" = "webui" ]; then
        echo "$(docker-get-status $DOCKER_WEBUI)"
    elif [ "$1" = "automatic" ]; then
        echo "$(docker-get-status $DOCKER_AUTOMATIC)"
    fi
}
llm-start() {
    if [ "$1" = "ollama" ]; then
        # build ollama (if non-existent) and start the container
        docker run -d -v ollama:/root/.ollama -p 11434:11434 --name $DOCKER_OLLAMA ollama/ollama || \
        docker start $DOCKER_OLLAMA
    elif [ "$1" = "webui" ]; then
    # build open-webui (if non-existent) and start the container
    docker run -d -p 3000:8080 \
        --add-host=host.docker.internal:host-gateway \
        -e AUTOMATIC1111_BASE_URL=http://host.docker.internal:7860/ \
        -e ENABLE_IMAGE_GENERATION=True \
        -v open-webui:/app/backend/data \
        --name $DOCKER_WEBUI \
        --restart always ghcr.io/open-webui/open-webui:main || \
    docker start $DOCKER_WEBUI
    elif [ "$1" = "automatic" ]; then
        # build automatic1111 (if non-existent) and start the container
        docker run -d -p 7860:7860 \
            --add-host=host.docker.internal:host-gateway \
            -v automatic1111:/app/backend/data \
            --name $DOCKER_AUTOMATIC \
            --restart always ghcr.io/automatic1111/automatic1111:main || \
        docker start $DOCKER_AUTOMATIC
    fi
}
llm-stop() {
    if [ "$1" = "ollama" ]; then
        docker stop $DOCKER_OLLAMA
    elif [ "$1" = "webui" ]; then
        docker stop $DOCKER_WEBUI
    elif [ "$1" = "automatic" ]; then
        docker stop $DOCKER_AUTOMATIC
    fi
}
llm() {
    if [ "$1" = "status" ]; then
        if [ "$2" = "all" ]; then
            echo "ollama: $(llm-status ollama), open-webui: $(llm-status webui), automatic1111: $(llm-status automatic)"
        elif [ "$2" = "overall" ]; then
            status_ollama="$(llm-status ollama)"
            status_webui="$(llm-status webui)"
            status_automatic="$(llm-status automatic)"
            if [ "$status_ollama" = "$status_webui" ] && [ "$status_webui" = "$status_automatic" ]; then
                echo "$status_ollama"
            else
                echo "unknown"
            fi
        else
            llm-status $2
        fi
        llm-status $2
    elif [ "$1" = "start" ]; then
        llm-start $2
    elif [ "$1" = "stop" ]; then
        llm-stop $2
    fi
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

# click event
if [ "$1" = "click" ]; then
    if [ "$(llm status 'overall')" = "active" ]; then
        firefox "http://localhost:8080/"
    else
        # start the services
        if [ "$(llm status 'ollama')" = "inactive" ]; then
            notify-info "info" "starting ollama" "this may take a while"
            llm start 'ollama'
        fi
        if [ "$(llm status 'webui')" = "inactive" ]; then
            notify-info "info" "starting webui" "this may take a while"
            llm start 'webui'
        fi
        if [ "$(llm status 'automatic')" = "inactive" ]; then
            notify-info "info" "starting automatic1111" "this may take a while"
            llm start 'automatic'
        fi
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
