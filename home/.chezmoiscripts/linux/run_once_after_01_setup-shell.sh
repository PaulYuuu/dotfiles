#!/bin/bash
set -euo pipefail

echo "Setting up zsh as default shell..."

# Get zsh path
ZSH_PATH=$(which zsh)

# Change default shell to zsh if not already set
if [ "${SHELL}" != "${ZSH_PATH}" ]; then
  echo "Changing default shell to zsh..."
  sudo chsh -s "${ZSH_PATH}" "${USER:-$(whoami)}"
  echo "Default shell changed to zsh. Please log out and log back in for changes to take effect."
else
  echo "zsh is already the default shell"
fi
