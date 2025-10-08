#!/bin/bash

set -eufo pipefail

# Ask for the administrator password upfront
echo "Applying system-level settings, administrator password required..."
sudo -v

echo "Setting power management options..."

# --- Power Management ---
sudo pmset -a displaysleep 30
sudo pmset -c sleep 0
sudo pmset -a autorestart 1

echo "System-level setup complete."
