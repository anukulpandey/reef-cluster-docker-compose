#!/bin/bash
set -e

# Variables
SSH_USER=${SSH_USER:-reefuser}
BASE_DIR="/home/$SSH_USER"

# Download reef-node binary
wget -O "$BASE_DIR/reef-node" "https://raw.githubusercontent.com/anukulpandey/reef-bootnode-dockerized/main/bin/reef-node"
chmod +x "$BASE_DIR/reef-node"

# Download customSpec.json
wget -O "$BASE_DIR/customSpec.json" "https://raw.githubusercontent.com/anukulpandey/reef-pelagia-testnet-customSpec.json/refs/heads/main/customSpec.json"

# Build customSpecRaw.json
"$BASE_DIR/reef-node" build-spec --disable-default-bootnode --chain "$BASE_DIR/customSpec.json" --raw > "$BASE_DIR/customSpecRaw.json"
