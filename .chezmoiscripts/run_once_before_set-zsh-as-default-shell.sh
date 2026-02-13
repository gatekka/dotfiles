#!/bin/bash

# Check if zsh is installed
if ! command -v zsh &>/dev/null; then
  echo "✗ Zsh is not installed. Please install it first."
  exit 1
fi

ZSH_PATH=$(which zsh)

CURRENT_SHELL=$(getent passwd "$USER" | cut -d: -f7)

if [ "$CURRENT_SHELL" = "$ZSH_PATH" ]; then
  echo "✓ Zsh is already the default shell"
  exit 0
fi

echo "Setting Zsh as default shell..."
chsh -s "$ZSH_PATH" # Set zsh as default shell

if [ $? -eq 0 ]; then
  echo "✓ Zsh set as default shell"
else
  echo "✗ Failed to set Zsh as default shell"
  exit 1
fi
