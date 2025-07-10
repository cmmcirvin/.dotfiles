#!/bin/bash

# Create local bin directory and add to PATH
mkdir -p "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$PATH"

# Create symbolic links for dotfiles
ln -sf ~/.dotfiles/.bashrc ~/.bashrc
ln -sf ~/.dotfiles/.bash_profile ~/.bash_profile
ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/.gitignore ~/.gitignore
ln -sf ~/.dotfiles/nvim ~/.config/nvim
ln -sf ~/.dotfiles/starship.toml ~/.config/starship.toml

# Create a virtual environment if Python is found
if command -v python3 >/dev/null 2>&1; then
    python3 -m venv ~/.venv
    source ~/.venv/bin/activate
    python3 -m pip install pynvim debugpy uv
elif command -v python >/dev/null 2>&1; then
    python -m venv ~/.venv
    source ~/.venv/bin/activate
    python -m pip install pynvim debugpy uv
else
    echo "No Python interpreter found. Skipping virtual environment creation."
fi

# Install Starship prompt if not already installed
command -v starship >/dev/null 2>&1 || curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir ~/.local/bin

# Install Neovim if not already installed
command -v nvim >/dev/null 2>&1 || { 
    mkdir -p ~/.local/bin 

    # Detect architecture
    ARCH=$(uname -m)
    case $ARCH in
        x86_64)
            NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86-64.appimage"
            ;;
        aarch64|arm64)
            NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-arm64.appimage"
            ;;
        *)
            echo "Unsupported architecture: $ARCH"
            exit 1
            ;;
    esac

    curl -L "$NVIM_URL" -o ~/.local/bin/nvim
    chmod +x ~/.local/bin/nvim
}
