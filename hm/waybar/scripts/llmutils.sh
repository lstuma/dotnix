#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR/utils.sh"

# names of the docker containers
OLLAMA="ollama"
WEBUI="open-webui"
AUTOMATIC="automatic1111"
SERVICES=($OLLAMA $WEBUI $AUTOMATIC)

_llm_status() {
    service_status=$(docker ps -q -f name="$1")
    if [ -z "$service_status" ]; then
        echo "inactive"
    else
        echo "active"
    fi
}

_llm_healthcheck() {
    if [ "$1" = "all" ]; then
        # display health status of all services
        for service in "${SERVICES[@]}"; do
            service_status=$(_llm_status $service)
            echo "$service: $service_status"
        done
        return
    elif [ "$1" = "overall" ]; then
        # display overall health status
        for service in "${SERVICES[@]}"; do
            service_status=$(_llm_status $service)
            if [ "$service_status" = "inactive" ]; then
                echo "inactive"
                return
            fi
        done
        echo "active"
        return
    fi
    # display health status of a specific service
    service_status=$(_llm_status $1)
    echo "$service_status"
}

_llm_docker_start() {
    docker_status="$(_llm_status $1)"
    if [ "$docker_status" = "active" ]; then
        return
    fi
    # start the service
    notify-info "info" "starting $1 ($status_service)" "starting the service"
    if [ "$1" = "ollama" ]; then
        # build ollama (if non-existent) and start the container
        (docker run -d -v ollama:/root/.ollama -p 11434:11434 \
        --name $OLLAMA --restart always ollama/ollama || \
        docker start $OLLAMA)&
    elif [ "$1" = "open-webui" ]; then
        # build open-webui (if non-existent) and start the container
        (docker run -d -p 7777:8080 \
            ° \
            -e AUTOMATIC1111_BASE_URL=http://host.docker.internal:7860/ \
            -e ENABLE_IMAGE_GENERATION=True \
            -v open-webui:/app/backend/data \
            --name $WEBUI \
            --restart always ghcr.io/open-webui/open-webui:main || \
        docker start $WEBUI)&
    elif [ "$1" = "automatic" ]; then
        # build automatic1111 (if non-existent) and start the container
        (docker run --gpus all -t -i -p 3000:3000 -p 8888:8888 \
        -e JUPYTER_PASSWORD='password' -v /home/lstuma/models/outputs/ --name "automatic1111" --privileged \
        -d --runtime=nvidia runpod/stable-diffusion:web-automatic-1.5 \
            --restart always ghcr.io/automatic1111/automatic1111:main || \
        docker start $AUTOMATIC)&
    fi
}

_llm_docker_stop() {
    docker_status="$(_llm_status $1)"
    if [ "$docker_status" = "inactive" ]; then
        return
    fi
    # stop the service
    notify-info "info" "stopping $1 ($status_service)" "stopping the service"
    docker stop $1
}

_llm_docker() {
    if [ "$1" = "start" ]; then
        _llm_docker_start $2
    elif [ "$1" = "stop" ]; then
        _llm_docker_stop $2
    elif [ "$1" = "toggle" ]; then
        docker_status="$(_llm_status $2)"
        if [ "$docker_status" = "active" ]; then
            _llm_docker_stop $2
        else
            _llm_docker_start $2
        fi
    fi
}

llm() {
    if [ "$1" = "health" ]; then
        _llm_healthcheck $2 $3 $4
    elif [ "$1" = "docker" ]; then
        _llm_docker $2 $3 $4
    fi
}

llm $1 $2 $3 $4
