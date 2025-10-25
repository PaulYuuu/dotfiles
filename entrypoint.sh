#!/bin/bash
set -euo pipefail

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

gum log --level info --level.foreground "108" "Testing dotfiles setup"
gum log ""

gum log --level debug --level.foreground "110" "Initializing dotfiles source"
chezmoi init
gum log --level info --level.foreground "108" "Dotfiles source initialized"
gum log ""

gum log --level debug --level.foreground "110" "Verifying system identification"
if ! chezmoi data | jq -e ".isEphemeral == true" >/dev/null; then
  gum log --level error --level.foreground "131" "System should be identified as ephemeral"
  exit 1
fi
gum log --level info --level.foreground "108" "isEphemeral = true"

if ! chezmoi data | jq -e ".isPersonal == false" >/dev/null; then
  gum log --level error --level.foreground "131" "System should not be identified as personal"
  exit 1
fi
gum log --level info --level.foreground "108" "isPersonal = false"
gum log ""

gum log --level debug --level.foreground "110" "Listing ignored targets"
IGNORED_OUTPUT=$(chezmoi ignored)
if [ -n "$IGNORED_OUTPUT" ]; then
  while IFS= read -r line; do
    gum log --level info --level.foreground "108" "$line"
  done <<<"$IGNORED_OUTPUT"
fi
gum log ""

gum log --level debug --level.foreground "110" "Applying dotfiles"
chezmoi apply --force
gum log --level info --level.foreground "108" "Dotfiles applied"
gum log ""

gum log --level debug --level.foreground "110" "Verifying dotfiles status"
STATUS_OUTPUT=$(chezmoi status)
if [ -z "$STATUS_OUTPUT" ]; then
  gum log --level info --level.foreground "108" "All dotfiles in sync"
else
  while IFS= read -r line; do
    gum log --level info --level.foreground "108" "$line"
  done <<<"$STATUS_OUTPUT"
fi
gum log ""

gum log --level info --level.foreground "108" "Dotfiles test passed"
