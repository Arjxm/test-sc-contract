#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Step 0: Ensure required environment variables are set
if [ -z "$BUILDBEAR_RPC_URL" ]; then
  echo "Error: BUILDBEAR_RPC_URL is not set. Please set it in the environment."
  exit 1
fi

if [ -z "$MNEMONIC" ]; then
  echo "Error: MNEMONIC is not set. Please set it in the environment."
  exit 1
fi

# Step 1: Install all necessary dependencies using pnpm
echo "Installing dependencies..."
forge install

# Step 2: Build all packages in the monorepo
echo "Building all packages..."
forge build


forge script script/DeployMarket.s.sol --rpc-url "$BUILDBEAR_RPC_URL" --mnemonics "$MNEMONIC" --broadcast --slow

echo "Deployment completed successfully."