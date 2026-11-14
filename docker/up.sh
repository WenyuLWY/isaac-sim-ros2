#!/bin/bash
mkdir -p ~/.cache/ov/hub
mkdir -p ../tmp/isaac/cache/{main,computecache,kit}
mkdir -p ../tmp/isaac/{logs,config,data,pkg}
mkdir -p ../tmp/hub
mkdir -p ../tmp/ros2/{build,install,log}

CACHE_DIRS=( ../tmp/ros2 ../tmp/isaac "$HOME/.cache/ov/hub" )
sudo setfacl -R -m u:1000:rwX,u:1234:rwX "${CACHE_DIRS[@]}"
sudo find "${CACHE_DIRS[@]}" -type d -exec setfacl -m d:u:1000:rwx,d:u:1234:rwx {} +

XAUTH="./docker.container.xauth"
rm -f "$XAUTH"
touch "$XAUTH"
xauth nlist "$DISPLAY" | sed -e 's/^..../ffff/' | xauth -f "$XAUTH" nmerge -
chmod 644 "$XAUTH"
# sudo chown -R 1234:1234 ../tmp/isaac ~/.cache/ov/hub

docker compose -p isaac_sim up -d