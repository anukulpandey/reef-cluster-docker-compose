#!/bin/bash
set -e

# Default SSH user
SSH_USER=${SSH_USER:-reef}

# Run download_binary.sh as the SSH user
echo "Running download_binary.sh..."
su - $SSH_USER -c "/home/$SSH_USER/scripts/download_binary.sh" || true

# Start SSHD in foreground
exec /usr/sbin/sshd -D
