# Dotfiles

All dotfiles are managed with [Chezmoi](https://chezmoi.io).

## Getting Started

### Install Dependencies

In order for my dotfiles to work correctly, the following packages/dependencies are required:

```bash
# Set zsh as default shell (You need to reboot for zsh to take effect)
chsh -s $(which zsh)
```

To install, initialize, and apply these dotfiles with Chezmoi, run the following commands:
```bash
chezmoi init --apply --branch hyprland https://github.com/gatekka/dotfiles.git
```
You can visit the [official Chezmoi installation page](https://chezmoi.io/install) for more options and details.

