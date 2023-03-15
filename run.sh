#!/bin/sh
docker run -it --rm \
    --name test-ros-dev-container \
    -u $(id -u):$(id -g) \
    -v $HOME/repo/test-dev-container:/home/user/test-dev-container \
    dev-ros-test-container:noetic /bin/zsh -c "roscore"