FROM ros:noetic-ros-base
ARG DEBIAN_FRONTEND=noninteractive

# Install basic apt packages
RUN apt update && apt upgrade -y && \
    apt install -y sudo vim wget curl zsh git python3-pip python3-catkin-tools python3-rosdep && \
    apt autoremove && apt clean

# Install pip packages
COPY requirements.txt /tmp/requirements.txt
RUN python3 -m pip install --no-cache-dir -r /tmp/requirements.txt

# Create user account
RUN adduser --disabled-password --gecos '' --shell /bin/zsh user && \
    echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-user

# Switch to user
USER user

# Install oh-my-zsh
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.2/zsh-in-docker.sh)" -- \
    -t ys \
    -p git \
	-p z \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-syntax-highlighting

SHELL ["/bin/zsh", "-c"]

RUN . /opt/ros/$ROS_DISTRO/setup.zsh && \
    mkdir -p /home/user/catkin_ws/src && cd /home/user/catkin_ws/src && \
    git clone https://github.com/CCNYRoboticsLab/imu_tools.git && \
    cd /home/user/catkin_ws && \
    catkin init && rosdep update && rosdep install --from-paths src --ignore-src -r -y  && \
    cd /home/user/catkin_ws && catkin build

COPY docker/ros_entrypoint.sh /
RUN sudo chmod +x /ros_entrypoint.sh && \
    sudo echo "source /opt/ros/$ROS_DISTRO/setup.zsh" >> ~/.zshrc && sudo echo "source /home/user/catkin_ws/devel/setup.zsh" >> ~/.zshrc

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["/bin/zsh"]