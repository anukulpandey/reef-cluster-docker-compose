#!/bin/bash
set -e

# Args
PORT=${1:-30334}              # Default: 30334
RPC_PORT=${2:-9945}           # Default: 9945
BOOTNODE=${3:-""}             # No default, must be passed if needed
VALIDATOR_NAME=${4:-validator-1} # Default: validator-1

# Variables
SSH_USER=${SSH_USER:-reefuser}
BASE_DIR="/home/$SSH_USER"
DATA_DIR="$BASE_DIR/data/$VALIDATOR_NAME"

# Ensure validator data directory exists
mkdir -p "$DATA_DIR"

# Run validator node
"$BASE_DIR/reef-node" \
  --base-path "$DATA_DIR" \
  --chain "$BASE_DIR/customSpecRaw.json" \
  --port "$PORT" \
  --rpc-port "$RPC_PORT" \
  --no-telemetry \
  --validator \
  --rpc-methods Unsafe \
  --name "$VALIDATOR_NAME" \
  --rpc-cors all \
  --rpc-external \
  --unsafe-rpc-external \
  --discover-local \
  --rpc-max-connections 10000 \
  --pruning=archive \
  ${BOOTNODE:+--bootnodes $BOOTNODE}
