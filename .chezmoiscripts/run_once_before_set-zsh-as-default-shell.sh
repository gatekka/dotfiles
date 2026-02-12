#!/bin/bash

# # Check if zsh is default shell
# if [ "$SHELL" = "$(which zsh)" ]; then
#   echo "✓ Zsh is already the default shell"
#   exit 0
# fi
#
# # Check if zsh is installed
# if ! command -v zsh &>/dev/null; then
#   echo "✗ Zsh is not installed. Please install it first."
#   exit 1
# fi
#
# # Path to zsh
# ZSH_PATH=$(which zsh)
#
# # # Check if zsh is in /etc/shells
# # if ! grep -q "^$ZSH_PATH$" /etc/shells; then
# #   echo "Adding $ZSH_PATH to /etc/shells..."
# #   echo "$ZSH_PATH" | sudo tee -a /etc/shells >/dev/null
# # fi
#
# echo "Setting Zsh as default shell..."
# chsh -s "$ZSH_PATH" # Set zsh as default shell
#
# if [ $? -eq 0 ]; then
#   echo "✓ Zsh set as default shell"
# else
#   echo "✗ Failed to set Zsh as default shell"
#   exit 1
# fi
