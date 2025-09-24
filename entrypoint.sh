#!/bin/bash
set -e

# Get SSH user/password from environment
SSH_USER=${SSH_USER:-reef}
SSH_PASS=${SSH_PASS:-reefpass}

# Create user if it doesn't exist
if ! id "$SSH_USER" &>/dev/null; then
    echo "Creating SSH user $SSH_USER..."
    useradd -m -s /bin/bash "$SSH_USER"
    echo "$SSH_USER:$SSH_PASS" | chpasswd
    adduser "$SSH_USER" sudo
fi

# Run the download script as SSH_USER
echo "Running download_binary.sh..."
su - "$SSH_USER" -c "/home/$SSH_USER/scripts/download_binary.sh"

# Start SSHD in foreground
exec /usr/sbin/sshd -D
