#!/usr/bin/env bash
# this script is for starting and stopping llm services (ollama, open-webui, comfyui)
#
# NOTE: management of these services is currently faciliated using docker

if [ "$1" = "status" ]; then
