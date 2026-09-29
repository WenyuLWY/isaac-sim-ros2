#!/bin/bash

PKG_ROOT_DIR=$(dirname "$(dirname "$(readlink -f "$0")")")

echo "$PKG_ROOT_DIR"

mkdir -p $PKG_ROOT_DIR/tmp/cache/{main,computecache,kit}
mkdir -p $PKG_ROOT_DIR/tmp/{logs,config,data,pkg,hub}

sudo chown -R 1234:1234 $PKG_ROOT_DIR/tmp

docker stop hub-cache
docker rm hub-cache

docker run --name hub-cache --rm -d --network=host \
    -v $PKG_ROOT_DIR/tmp/hub:/var/cache/hub:rw \
    -u 1234:1234 \
    nvcr.io/nvidia/omniverse/hub_workstation_cache:2.2.0

# xhost +local:
# docker run --name isaac-sim --entrypoint bash -it --gpus all -e "ACCEPT_EULA=Y" --rm --network=host \
#     -e "PRIVACY_CONSENT=Y" \
#     -v $HOME/.Xauthority:/isaac-sim/.Xauthority \
#     -e DISPLAY \
#     -v $PKG_ROOT_DIR/tmp/cache/main:/isaac-sim/.cache:rw \
#     -v $PKG_ROOT_DIR/tmp/cache/computecache:/isaac-sim/.nv/ComputeCache:rw \
#     -v $PKG_ROOT_DIR/tmp/cache/kit:/isaac-sim/kit/cache:rw \
#     -v $PKG_ROOT_DIR/tmp/logs:/isaac-sim/.nvidia-omniverse/logs:rw \
#     -v $PKG_ROOT_DIR/tmp/config:/isaac-sim/.nvidia-omniverse/config:rw \
#     -v $PKG_ROOT_DIR/tmp/data:/isaac-sim/.local/share/ov/data:rw \
#     -v $PKG_ROOT_DIR/tmp/pkg:/isaac-sim/.local/share/ov/pkg:rw \
#     -v $PKG_ROOT_DIR/tmp/hub:/var/cache/hub:rw \
#     -u 1234:1234 \
#     nvcr.io/nvidia/isaac-sim:6.1.0

docker run --name isaac-sim --entrypoint bash -it --gpus all -e "ACCEPT_EULA=Y" --rm --network=host \
    -e "PRIVACY_CONSENT=Y" \
    -v $PKG_ROOT_DIR/tmp/cache/main:/isaac-sim/.cache:rw \
    -v $PKG_ROOT_DIR/tmp/cache/computecache:/isaac-sim/.nv/ComputeCache:rw \
    -v $PKG_ROOT_DIR/tmp/cache/kit:/isaac-sim/kit/cache:rw \
    -v $PKG_ROOT_DIR/tmp/logs:/isaac-sim/.nvidia-omniverse/logs:rw \
    -v $PKG_ROOT_DIR/tmp/config:/isaac-sim/.nvidia-omniverse/config:rw \
    -v $PKG_ROOT_DIR/tmp/data:/isaac-sim/.local/share/ov/data:rw \
    -v $PKG_ROOT_DIR/tmp/pkg:/isaac-sim/.local/share/ov/pkg:rw \
    -v $PKG_ROOT_DIR/tmp/hub:/var/cache/hub:rw \
    -u 1234:1234 \
    nvcr.io/nvidia/isaac-sim:6.1.0