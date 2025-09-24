#!/bin/bash
set -e

echo "[DEBUG] Starting start.sh..."

# Start SSH
echo "[DEBUG] Starting SSHD..."
/usr/sbin/sshd
echo "[DEBUG] SSHD started."

# Start tmux bootstrap session (as root)
echo "[DEBUG] Starting tmux session 'bootstrap'..."
tmux new-session -d -s bootstrap "/home/reefuser/scripts/bootstrap.sh"
echo "[DEBUG] tmux session started."

# Keep container alive
echo "[DEBUG] Container will now stay alive..."
tail -f /dev/null
