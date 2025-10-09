#!/bin/bash
set -euo pipefail

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
RESET='\033[0m'

# Create symlink for GitHub Actions
if [ -d "/github/workspace" ] && [ ! -e "/dotfiles" ]; then
  sudo ln -s /github/workspace /dotfiles
  HOME="/home/$(whoami)"
  export HOME
fi

# Use /dotfiles as source directory
SOURCE_DIR="/dotfiles"

# Wrapper function to always use the correct source directory
chezmoi() {
  command chezmoi --source="${SOURCE_DIR}" "$@"
}

echo -e "${BLUE}=== Chezmoi Configuration Test ===${RESET}"
echo "Source directory: ${SOURCE_DIR}"
echo ""

# Install jq for JSON parsing
echo "Installing dependencies..."
sudo dnf install -y -q jq
echo -e "${GREEN}✓ Dependencies installed${RESET}"
echo ""

# Initialize chezmoi
echo -e "${BLUE}=== Initializing chezmoi ===${RESET}"
chezmoi init
echo -e "${GREEN}✓ Chezmoi initialized${RESET}"
echo ""

# Verify system identification
echo -e "${BLUE}=== Verifying system identification ===${RESET}"
if ! chezmoi data | jq -e ".isEphemeral == true" >/dev/null; then
  echo -e "${RED}✗ Failed: System should be identified as ephemeral${RESET}"
  exit 1
fi
echo -e "${GREEN}✓ isEphemeral = true${RESET}"

if ! chezmoi data | jq -e ".isPersonal == false" >/dev/null; then
  echo -e "${RED}✗ Failed: System should not be identified as personal${RESET}"
  exit 1
fi
echo -e "${GREEN}✓ isPersonal = false${RESET}"
echo ""

# Show ignored files
echo -e "${BLUE}=== Ignored files ===${RESET}"
chezmoi ignored
echo ""

# Apply configuration
echo -e "${BLUE}=== Applying configuration ===${RESET}"
chezmoi apply --force
echo -e "${GREEN}✓ Configuration applied${RESET}"
echo ""

# Show status
echo -e "${BLUE}=== Configuration status ===${RESET}"
chezmoi status
echo ""

echo -e "${GREEN}=== All tests passed! ===${RESET}"
