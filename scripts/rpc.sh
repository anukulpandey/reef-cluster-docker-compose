#!/bin/bash
set -e

# Args
PORT=${1:-30335}        # Default p2p port
RPC_PORT=${2:-9946}     # Default RPC port
BOOTNODE=${3:-""}       # Bootnode to connect with

# Variables
SSH_USER=${SSH_USER:-reefuser}
BASE_DIR="/home/$SSH_USER"
DATA_DIR="$BASE_DIR/data/rpcnode"

# Ensure RPC node data directory exists
mkdir -p "$DATA_DIR"

# Run RPC-only node (full node, non-validator)
"$BASE_DIR/reef-node" \
  --base-path "$DATA_DIR" \
  --chain "$BASE_DIR/customSpecRaw.json" \
  --port "$PORT" \
  --rpc-port "$RPC_PORT" \
  --no-telemetry \
  --rpc-methods Unsafe \
  --name "rpc-node" \
  --rpc-cors all \
  --rpc-external \
  --unsafe-rpc-external \
  --discover-local \
  --rpc-max-connections 10000 \
  --pruning=archive \
  ${BOOTNODE:+--bootnodes $BOOTNODE}
