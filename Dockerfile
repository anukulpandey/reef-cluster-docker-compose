FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    openssh-server sudo wget ca-certificates python3 \
    && rm -rf /var/lib/apt/lists/*

# Setup SSH
RUN mkdir /var/run/sshd

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN /entrypoint.sh

# Copy scripts
COPY scripts/ /home/scripts/
RUN chmod +x /home/scripts/*.sh


# Expose SSH
EXPOSE 22

# Keep SSHD running as the main command
CMD ["/usr/sbin/sshd", "-D"]
