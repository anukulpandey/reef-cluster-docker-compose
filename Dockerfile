FROM ubuntu:22.04

# Install OpenSSH, sudo, wget
RUN apt-get update && apt-get install -y \
    openssh-server sudo wget ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Create SSH user from build args
ARG SSH_USER=reefuser
ARG SSH_PASS=reefpass
RUN useradd -m -s /bin/bash $SSH_USER && \
    echo "$SSH_USER:$SSH_PASS" | chpasswd && \
    adduser $SSH_USER sudo

# Setup SSH daemon
RUN mkdir /var/run/sshd

# Download reef-node binary
RUN wget -O /usr/local/bin/reef-node https://raw.githubusercontent.com/anukulpandey/reef-bootnode-dockerized/main/bin/reef-node \
    && chmod +x /usr/local/bin/reef-node

# Expose SSH port
EXPOSE 22

# Start SSH in foreground
CMD ["/usr/sbin/sshd", "-D"]
