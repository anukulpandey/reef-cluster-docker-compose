#!/bin/bash
set -e

# Run the download script as SSH_USER
echo "Running download_binary.sh..."
su - "$SSH_USER" -c "/home/$SSH_USER/scripts/download_binary.sh"
