FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    openssh-server sudo wget ca-certificates python3 \
    && rm -rf /var/lib/apt/lists/*

# Setup SSH
RUN mkdir /var/run/sshd

# Copy scripts and entrypoint
COPY scripts/ /home/scripts/
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /home/scripts/*.sh /entrypoint.sh

# Expose SSH
EXPOSE 22

# Run entrypoint
ENTRYPOINT ["/entrypoint.sh"]
