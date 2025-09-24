FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    openssh-server sudo wget ca-certificates python3 \
    && rm -rf /var/lib/apt/lists/*

# Setup SSH
RUN mkdir /var/run/sshd

# Build args for SSH user
ARG SSH_USER=reef
ARG SSH_PASS=reefpass

# Set environment variables (so they are available in container)
ENV SSH_USER=${SSH_USER} \
    SSH_PASS=${SSH_PASS}

# Create SSH user at build time
RUN useradd -m -s /bin/bash $SSH_USER && \
    echo "$SSH_USER:$SSH_PASS" | chpasswd && \
    adduser $SSH_USER sudo

# Copy scripts to the user home
COPY scripts/ /home/${SSH_USER}/scripts/
RUN chmod +x /home/${SSH_USER}/scripts/*.sh

# Copy entrypoint if needed
COPY entrypoint.sh /home/${SSH_USER}/entrypoint.sh
RUN chmod +x /home/${SSH_USER}/entrypoint.sh

# Expose SSH port
EXPOSE 22

# Keep SSHD running as the main process
CMD ["/usr/sbin/sshd", "-D"]
