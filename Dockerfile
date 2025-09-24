FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    openssh-server sudo wget ca-certificates python3 \
    && rm -rf /var/lib/apt/lists/*

# Build args for SSH user
ARG SSH_USER
ARG SSH_PASS

# Create the SSH user dynamically
RUN useradd -m -s /bin/bash $SSH_USER && \
    echo "$SSH_USER:$SSH_PASS" | chpasswd && \
    adduser $SSH_USER sudo

# Setup SSH
RUN mkdir /var/run/sshd

# Copy scripts and entrypoint
COPY scripts/ /home/${SSH_USER}/scripts/
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /home/${SSH_USER}/scripts/*.sh /entrypoint.sh

# Expose SSH port
EXPOSE 22

# Use entrypoint to run script + SSHD
ENTRYPOINT ["/entrypoint.sh"]
