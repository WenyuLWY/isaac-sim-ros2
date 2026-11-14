#!/bin/bash
# source config.env
# docker build -t ${IMAGE_NAME} -f Dockerfile .
COMPOSE_BAKE=true docker compose -p isaac_sim build ros2-jazzy
