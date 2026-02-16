# Dotfiles

All dotfiles are managed with [Chezmoi](https://chezmoi.io).

![](https://image.gatekka.com/dotfiles1.jpg)

## Getting Started

> [!WARNING]
> These dotfiles are a living workspace and not fully polished. Do not run this command if you expect to replicate my exact system or don't know what you're doing. It will overwrite your configuration files and is irreversible!

To install, initialize, and apply these dotfiles with Chezmoi, run the following command:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin init --apply gatekka
```

You can visit the [official Chezmoi installation page](https://chezmoi.io/install) for more options and details.

## Featured Tools

These tools are configured in my dotfiles but aren’t included or installed automatically.

- hyprlock — screen lock
- hyprsplit — separate sets of workspaces per monitor
- wlogout — logout menu
- Vicinae — launcher
- Waybar — status bar
- AWWW / SWWW — handling wallpapers
- Matugen — color generation
- SwayNC — notification center

## More Screenshots

![](https://image.gatekka.com/dotfiles2.jpg)
![](https://image.gatekka.com/dotfiles3.jpg)
![](https://image.gatekka.com/dotfiles4.jpg)

## Other Notes

### Enable FN mode toggle on Nuphy Halo 75 keyboard

For Halo 75 users, the FN mode doesn't work natively on Linux. [Thanks to this post](https://www.reddit.com/r/NuPhy/comments/1dyjkqy/comment/lc9i17p/), to fix this run the following commands:

```bash
# Set fnmode=2
echo options hid_apple fnmode=2 | sudo tee -a /etc/modprobe.d/hid_apple.conf
# Reboot to apply changes
reboot
```
