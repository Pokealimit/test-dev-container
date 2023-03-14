FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive

# Install basic apt packages
RUN apt update && apt upgrade -y && \
    apt install -y sudo vim wget curl zsh git python3-pip && \
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

CMD ["/bin/zsh"]