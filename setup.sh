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
ln -sfn ~/.dotfiles/kitty ~/.config/kitty
ln -sf ~/.dotfiles/starship.toml ~/.config/starship.toml

command -v bat >/dev/null 2>&1 || {
    BAT_VERSION="0.24.0"
    OS=$(uname -s | tr '[:upper:]' '[:lower:]')
    ARCH=$(uname -m)

    case "$OS" in
        darwin)
            [[ "$ARCH" == "x86_64" ]] && BAT_ARCH="x86_64-apple-darwin" || BAT_ARCH="aarch64-apple-darwin"
            ;;
        linux)
            [[ "$ARCH" == "x86_64" ]] && BAT_ARCH="x86_64-unknown-linux-musl" || BAT_ARCH="aarch64-unknown-linux-musl"
            ;;
    esac

    BAT_URL="https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat-v${BAT_VERSION}-${BAT_ARCH}.tar.gz"

    mkdir -p "$HOME/.local/bin"
    TEMP_DIR=$(mktemp -d)

    curl -L "$BAT_URL" | tar -xz -C "$TEMP_DIR"
    find "$TEMP_DIR" -type f -name "bat" -exec mv {} "$HOME/.local/bin/bat" \;
    
    chmod +x "$HOME/.local/bin/bat"
    rm -rf "$TEMP_DIR"
}
command -v delta >/dev/null 2>&1 || {
    DELTA_VERSION="0.19.1"
    OS=$(uname -s | tr '[:upper:]' '[:lower:]')
    ARCH=$(uname -m)

    # Map OS and Architecture to the correct release string
    case "$OS" in
        darwin)
            [[ "$ARCH" == "x86_64" ]] && DELTA_ARCH="x86_64-apple-darwin" || DELTA_ARCH="aarch64-apple-darwin"
            ;;
        linux)
            [[ "$ARCH" == "x86_64" ]] && DELTA_ARCH="x86_64-unknown-linux-musl" || DELTA_ARCH="aarch64-unknown-linux-musl"
            ;;
        *) echo "Unsupported OS: $OS"; exit 1 ;;
    esac

    DELTA_URL="https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/delta-${DELTA_VERSION}-${DELTA_ARCH}.tar.gz"

    mkdir -p "$HOME/.local/bin"
    TEMP_DIR=$(mktemp -d)
    
    echo "Downloading delta from $DELTA_URL..."
    curl -L "$DELTA_URL" | tar -xz -C "$TEMP_DIR"

    # Locate the binary regardless of the internal folder structure
    find "$TEMP_DIR" -type f -name "delta" -exec mv {} "$HOME/.local/bin/delta" \;

    chmod +x "$HOME/.local/bin/delta"
    rm -rf "$TEMP_DIR"
    echo "delta installed to ~/.local/bin/delta"
}

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

# Download git-completion if missing
if [ ! -f ~/.git-completion.bash ]; then
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
fi
