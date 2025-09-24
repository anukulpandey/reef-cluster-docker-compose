FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    openssh-server sudo wget ca-certificates tmux \
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

# Switch to root to copy scripts
USER root
WORKDIR /home/$SSH_USER

# Copy scripts folder
COPY scripts /home/$SSH_USER/scripts
RUN chmod +x /home/$SSH_USER/scripts/*.sh

# Run the init script
RUN /home/$SSH_USER/scripts/init_binary.sh
RUN /home/$SSH_USER/scripts/bootstrap.sh

# Expose SSH
EXPOSE 22

# Start SSHD
CMD ["/usr/sbin/sshd", "-D"]
