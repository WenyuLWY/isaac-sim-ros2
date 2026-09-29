#!/bin/bash

PKG_ROOT_DIR=$(dirname "$(dirname "$(readlink -f "$0")")")

echo "$PKG_ROOT_DIR"

mkdir -p $PKG_ROOT_DIR/tmp/isaac/cache/{main,computecache,kit}
mkdir -p $PKG_ROOT_DIR/tmp/isaac/{logs,config,data,pkg}
mkdir -p $PKG_ROOT_DIR/tmp/hub
mkdir -p $PKG_ROOT_DIR/tmp/ros2/{build,install,log}

sudo chown -R 1234:1234 $PKG_ROOT_DIR/tmp/isaac $PKG_ROOT_DIR/tmp/hub

# docker stop hub-cache
# docker rm hub-cache

# docker run --name hub-cache --rm -d --network=host \
#     -v $PKG_ROOT_DIR/tmp/hub:/var/cache/hub:rw \
#     -u 1234:1234 \
#     nvcr.io/nvidia/omniverse/hub_workstation_cache:2.2.0
