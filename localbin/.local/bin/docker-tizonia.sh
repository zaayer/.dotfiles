#!/usr/bin/env bash

USER_ID=$(id -u);
GROUP_ID=$(id -g);

docker run -it --rm \
    -e PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native \
    --volume=${XDG_RUNTIME_DIR}/pulse:${XDG_RUNTIME_DIR}/pulse \
    --volume="${HOME}/.config/tizonia":/home/tizonia/.config/tizonia \
    --volume "${HOME}/.config/pulse/cookie":/home/tizonia/.config/pulse/cookie \
    --name tizonia \
    tizonia/docker-tizonia "$@";
