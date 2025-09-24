FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    openssh-server sudo wget ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Build args for SSH user
ARG SSH_USER=reefuser
ARG SSH_PASS=reefpass

# Create user
RUN useradd -m -s /bin/bash $SSH_USER && \
    echo "$SSH_USER:$SSH_PASS" | chpasswd && \
    adduser $SSH_USER sudo

# Setup SSH
RUN mkdir /var/run/sshd

# Switch to the user
USER $SSH_USER
WORKDIR /home/$SSH_USER

# Download reef-node binary
RUN wget -O /home/$SSH_USER/reef-node https://raw.githubusercontent.com/anukulpandey/reef-bootnode-dockerized/main/bin/reef-node && \
    chmod +x /home/$SSH_USER/reef-node

# Download customSpec.json
RUN wget -O /home/$SSH_USER/customSpec.json https://raw.githubusercontent.com/anukulpandey/reef-pelagia-testnet-customSpec.json/refs/heads/main/customSpec.json

# Build customSpecRaw.json
RUN /home/$SSH_USER/reef-node build-spec --disable-default-bootnode --chain /home/$SSH_USER/customSpec.json --raw > /home/$SSH_USER/customSpecRaw.json

# Expose SSH
EXPOSE 22

# Switch back to root to start SSHD
USER root
CMD ["/usr/sbin/sshd", "-D"]