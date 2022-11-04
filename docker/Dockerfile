FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive

# Change accordingly to your host account $UID and $GID (to enable consistent permission for bind mount for host and container)
ARG uid=1000
ARG gid=1000
ARG user_name=user

# Install basic apt packages
RUN apt update && apt upgrade -y && \
    apt install -y sudo vim wget curl zsh git python3-pip && \
    apt autoremove && apt clean

# Install pip packages
COPY requirements.txt /tmp/requirements.txt
RUN python3 -m pip install --no-cache-dir -r /tmp/requirements.txt

# Create user account
RUN groupadd --gid ${uid} ${user_name} && \
    useradd --uid ${gid} --gid ${user_name} --groups sudo --create-home user --shell /bin/zsh && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers 

# Switch to user
USER ${uid}:${gid}

# Install oh-my-zsh
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.2/zsh-in-docker.sh)" -- \
    -t ys \
    -p git \
	-p z \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-syntax-highlighting

CMD ["/bin/zsh"]