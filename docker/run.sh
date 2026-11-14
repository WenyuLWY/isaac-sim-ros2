#!/bin/bash

# docker run -it --rm isaac_sim-ros2-humble  /bin/bash
# docker compose -p isaac_sim up --no-deps ros2-humble

docker compose -p isaac_sim down

XAUTH="./docker.container.xauth"
rm -f "$XAUTH"
touch "$XAUTH"
xauth nlist "$DISPLAY" | sed -e 's/^..../ffff/' | xauth -f "$XAUTH" nmerge -
chmod 644 "$XAUTH"

COMPOSE_BAKE=true docker compose -p isaac_sim up -d --build
# docker compose -p isaac_sim run --rm -it --no-deps ros2-humble