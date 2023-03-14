#!/bin/sh
docker run -it --rm \
    --name test-dev-container \
    -u $(id -u):$(id -g) \
    -v $HOME/repo/test-dev-container:/home/user/test-dev-container \
    dev-test-container:22.04 /bin/zsh