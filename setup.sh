mkdir -p "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$PATH"

ln -sf ~/.dotfiles/.bashrc ~/.bashrc
ln -sf ~/.dotfiles/.zshrc ~/.zshrc

mkdir -p ~/.config/fish/
ln -sf ~/.dotfiles/config.fish ~/.config/fish/config.fish
ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/.gitignore ~/.gitignore

ln -sf ~/.dotfiles/nvim ~/.config/nvim
ln -sf ~/.dotfiles/starship.toml ~/.config/starship.toml

# Install Starship prompt if not already installed
command -v starship >/dev/null 2>&1 || curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir ~/.local/bin

# Install Neovim if not already installed
command -v nvim >/dev/null 2>&1 || { mkdir -p ~/.local/bin && curl -sL https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -o ~/.local/bin/nvim && chmod +x ~/.local/bin/nvim; }

command -v fish >/dev/null 2>&1 || {chsh -s $(which fish)}
