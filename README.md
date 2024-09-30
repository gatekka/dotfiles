# Dotfiles

All dotfiles are managed with [Chezmoi](https://www.chezmoi.io/).

## Getting Started

To install, initialize, and apply these dotfiles with Chezmoi, run the following commands:
```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
chezmoi init --apply git@github.com:gatekka/dotfiles.git
```
You can visit the [official Chezmoi installation page](https://chezmoi.io/install) for more options and details.
