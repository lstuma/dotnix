#!/usr/bin/env bash
# this script is for starting and stopping llm services (ollama, open-webui, comfyui)
#
# NOTE: management of these services is currently faciliated using docker

if [ "$1" = "status" ]; then
    exit 0
elif [ "$1" = "start" ]; then
    exit 0
elif [ "$1" = "stop" ]; then
    exit 0
fi

echo "Usage: $0 [status|start|stop]"
