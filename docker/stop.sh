#!/bin/bash

PKG_ROOT_DIR=$(dirname "$(dirname "$(readlink -f "$0")")")

XAUTH="$(dirname "$(readlink -f "$0")")/.docker.container.xauth"

COMPOSE_BAKE=true \
XAUTH_PATH=$XAUTH \
PKG_ROOT_DIR=$PKG_ROOT_DIR \
ISAAC_SIM_IMAGE=nvcr.io/nvidia/isaac-sim:6.1.0 \
ISAAC_SIM_DATA=$PKG_ROOT_DIR/tmp/isaac \
ISAACSIM_HUB_CACHE_PATH=$PKG_ROOT_DIR/tmp/hub \
    docker compose -p isim -f docker-compose.yml down
