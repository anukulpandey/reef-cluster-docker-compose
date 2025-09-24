#!/bin/bash
set -e

# Variables
SSH_USER=${SSH_USER:-reefuser}
BASE_DIR="/home/$SSH_USER"
DATA_DIR="$BASE_DIR/data/bootstrap"
TMUX_SESSION="bootstrap"

# Ensure bootstrap data directory exists
mkdir -p "$DATA_DIR"

# Generate node key
"$BASE_DIR/reef-node" key generate-node-key --file "$DATA_DIR/node.key"

# Start reef-node in a tmux session
tmux new-session -d -s "$TMUX_SESSION" \
  "$BASE_DIR/reef-node --base-path $DATA_DIR \
  --chain $BASE_DIR/customSpecRaw.json \
  --port 30333 \
  --rpc-port 9944 \
  --no-telemetry \
  --validator \
  --rpc-methods Unsafe \
  --name bootstrap-node \
  --rpc-cors all \
  --rpc-external \
  --unsafe-rpc-external \
  --node-key-file $DATA_DIR/node.key"
