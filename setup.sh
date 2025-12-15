#!/bin/bash

# Create local bin directory and add to PATH
mkdir -p "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$PATH"

# Create symbolic links for dotfiles
ln -sf ~/.dotfiles/.bashrc ~/.bashrc
ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf
# ln -sf ~/.dotfiles/.tmux ~/.tmux
ln -sf ~/.dotfiles/.bash_profile ~/.bash_profile
ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/.gitignore ~/.gitignore
ln -sfn ~/.dotfiles/nvim ~/.config/nvim
ln -sf ~/.dotfiles/starship.toml ~/.config/starship.toml


command -v uv >/dev/null 2>&1 || {
    curl -LsSf https://astral.sh/uv/install.sh | sh
    uv venv ~/.nvim_venv
    uv pip install --python ~/.nvim_venv/bin/python pynvim
    # uv tool install --upgrade pynvim
}

# Install Starship prompt if not already installed
command -v starship >/dev/null 2>&1 || curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir ~/.local/bin

# Install Neovim if not already installed
command -v nvim >/dev/null 2>&1 || { 

    # Detect architecture
    ARCH=$(uname -m)
    case $ARCH in
        x86_64)
            NVIM_URL="https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.appimage"
            ;;
        aarch64|arm64)
            NVIM_URL="https://github.com/neovim/neovim/releases/download/stable/nvim-linux-arm64.appimage"
            ;;
        *)
            echo "Unsupported architecture: $ARCH"
            exit 1
            ;;
    esac

    curl -L "$NVIM_URL" -o ~/.local/bin/nvim
    chmod +x ~/.local/bin/nvim
}

# Install TPM (Tmux Plugin Manager) if not already installed
[ ! -d ~/.tmux/plugins/tpm ] && mkdir -p ~/.tmux/plugins && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
