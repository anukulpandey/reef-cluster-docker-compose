#!/bin/bash
set -e

# Default SSH user if not set
SSH_USER=${SSH_USER:-reef}
USER_HOME="/home/$SSH_USER"
NODE_DIR="$USER_HOME/reef-node"

# Create directories if missing
mkdir -p "$NODE_DIR/chain"

# Download reef-node binary
echo "Downloading reef-node binary..."
wget -O "$NODE_DIR/reef-node" https://raw.githubusercontent.com/anukulpandey/reef-bootnode-dockerized/main/bin/reef-node
chmod +x "$NODE_DIR/reef-node"

# Download customSpec.json
echo "Downloading customSpec.json..."
wget -O "$NODE_DIR/chain/customSpec.json" https://raw.githubusercontent.com/anukulpandey/reef-pelagia-testnet-customSpec.json/refs/heads/main/customSpec.json

# Build customSpecRaw.json
echo "Building customSpecRaw.json..."
$NODE_DIR/reef-node build-spec \
    --disable-default-bootnode \
    --chain "$NODE_DIR/chain/customSpec.json" \
    --raw > "$NODE_DIR/chain/customSpecRaw.json"

echo "Download and build complete!"
