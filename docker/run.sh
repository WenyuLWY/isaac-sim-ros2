#!/bin/bash

PKG_ROOT_DIR=$(dirname "$(dirname "$(readlink -f "$0")")")

mkdir -p $PKG_ROOT_DIR/tmp/isaac/cache/{main,computecache,kit}
mkdir -p $PKG_ROOT_DIR/tmp/isaac/{logs,config,data,pkg}
mkdir -p $PKG_ROOT_DIR/tmp/hub
mkdir -p $PKG_ROOT_DIR/tmp/ros2/{build,install,log}

XAUTH="$(dirname "$(readlink -f "$0")")/.docker.container.xauth"
rm -f "$XAUTH"
touch "$XAUTH"
xauth nlist "$DISPLAY" | sed -e 's/^..../ffff/' | xauth -f "$XAUTH" nmerge -
chmod 644 "$XAUTH"

COMPOSE_BAKE=true \
XAUTH_PATH=$XAUTH \
PKG_ROOT_DIR=$PKG_ROOT_DIR \
ISAAC_SIM_IMAGE=nvcr.io/nvidia/isaac-sim:6.1.0 \
ISAAC_SIM_DATA=$PKG_ROOT_DIR/tmp/isaac \
ISAACSIM_HUB_CACHE_PATH=$PKG_ROOT_DIR/tmp/hub \
    docker compose -p isim -f docker-compose.yml up --build -d