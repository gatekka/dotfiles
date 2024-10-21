# Dotfiles

All dotfiles are managed with [Chezmoi](https://chezmoi.io).

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
apt install -y sudo curl git wget fd-find unzip build-essential zsh libreadline-dev

# Install nvm (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
source $HOME/.bashrc
# Download and Install Node.js (you may need to restart the terminal)
nvm install 23
# Set zsh as default shell
sudo chsh -s $(which zsh) $USER
```

### Install zsh plugins

To install zsh plugins run the following commands:

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/wting/autojump ~/.zsh/autojump && cd ~/.zsh/autojump/ && ./install.py
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
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
