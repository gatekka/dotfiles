# Dotfiles

All dotfiles are managed with [Chezmoi](https://chezmoi.io).

![Image of Desktop](https://i.imgur.com/Tx1Psc3.png)

## Getting Started

Make sure `$HOME/.local/bin` is in PATH:

```bash
grep -qxF 'export PATH="$HOME/.local/bin:$PATH"' $HOME/.bashrc || echo 'export PATH="$HOME/.local/bin:$PATH"' >> $HOME/.bashrc
source $HOME/.bashrc
```

To install, initialize, and apply these dotfiles with Chezmoi, run the following commands:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
chezmoi init --apply https://github.com/gatekka/dotfiles.git
```

You can visit the [official Chezmoi installation page](https://chezmoi.io/install) for more options and details.

### Install Dependencies

In order for my dotfiles to work correctly, the following packages/dependencies are required:

```bash
apt update
apt upgrade -y
apt install -y sudo curl git wget fd-find unzip build-essential zsh tmux

# Install nvm (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
source $HOME/.bashrc
# Download and Install Node.js (you may need to restart the terminal)
nvm install 23
# Set zsh as default shell (You need to reboot for zsh to take effect)
chsh -s $(which zsh)
```

### Install zsh plugins

To install zsh plugins run the following commands:

```bash
# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
# Install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
# Install autojump
git clone https://github.com/wting/autojump ~/.zsh/autojump && cd ~/.zsh/autojump/ && ./install.py
# Install Starship
curl -sS https://starship.rs/install.sh | sh
# Install powerlevel10k
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
```

You may need to logout and log back in for zsh to take effect.

### Installing Neovim

```bash
export INSTALL_DIR="$HOME/.local/bin"
mkdir -p $INSTALL_DIR
curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz -o $INSTALL_DIR/nvim-linux64.tar.gz
tar xzvf $INSTALL_DIR/nvim-linux64.tar.gz -C $INSTALL_DIR/
ln -s $INSTALL_DIR/nvim-linux64/bin/nvim $INSTALL_DIR/nvim
```

You can uninstall Neovim with:

```bash
export INSTALL_DIR="$HOME/.local/bin"
rm -rf $INSTALL_DIR/nvim-linux64.tar.gz $INSTALL_DIR/nvim-linux64
```

### Install LazyGit

```bash
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit.tar.gz lazygit
```

## Optional

### Installing Vivify

```bash
export INSTALL_DIR="$HOME/.local/bin"
mkdir -p $INSTALL_DIR
curl -LO https://github.com/jannis-baum/Vivify/releases/download/v0.6.0/vivify-linux.tar.gz
tar xf vivify-linux.tar.gz
cp vivify-linux/viv vivify-linux/vivify-server $INSTALL_DIR
```

### Docker Container

Commands can be ran in a docker container. Deploy the container with:

```bash
docker run --platform linux/amd64 -it ubuntu /bin/bash
```

## Archlinux (Hyprland)

To install Archlinux Hyprland dotfiles run the following commands:

```bash
# Install yay
sudo pacman -S --needed --noconfirm git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

# Install packages with yay
yay -S --needed --noconfirm autojump base base-devel bitwarden blueberry btop bulky cava chezmoi dunst fastfetch fd ffmpeg4.4 ffmpegthumbnailer firefox fzf git go hypridle hyprland hyprlock hyprpaper hyprpolkitagent-git hyprshade hyprshot hyprsunset hyprutils-git hyprwall inotify-tools iwgtk kitty lazygit linux linux-firmware losslesscut-bin mpv nemo neovide neovim networkmanager noto-fonts noto-fonts-emoji noto-fonts-extra npm ntfs-3g nvidia nwg-look obs-studio pavucontrol pipewire pipewire-alsa pipewire-audio pipewire-pulse pnpm python-pywal qt5-wayland qview reflector ripgrep rofi-wayland rose-pine-cursor spotify-launcher starship stremio timeshift tmux unzip vesktop vim waybar wget wl-clipboard wlogout xdg-desktop-portal-hyprland xdg-utils xorg-xev xorg-xhost yay yay-debug zellij zsh zsh-autosuggestions zsh-syntax-highlighting

rustup default stable # run this for cord.nvim plugin or it'll cry about not building properly

# Installing OhMyZsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

```bash
# Apply dotfiles with chezmoi
chezmoi init --apply https://github.com/gatekka/dotfiles.git
```

You may need to reboot to apply changes.

### Enable FN mode toggle on Nuphy Halo 75 keyboard

For Halo 75 users, the FN mode doesn't work natively on Linux. [Thanks to this post](https://www.reddit.com/r/NuPhy/comments/1dyjkqy/comment/lc9i17p/), to fix this run the following commands:

```bash
# Set fnmode=2
echo options hid_apple fnmode=2 | sudo tee -a /etc/modprobe.d/hid_apple.conf
# Reboot to apply changes
reboot
```
