ln -sf ~/.dotfiles/.bashrc ~/.bashrc
ln -sf ~/.dotfiles/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/.profile ~/.profile
ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/.gitignore ~/.gitignore
ln -sf ~/.dotfiles/.remote_shell_configs .remote_shell_configs

ln -sf ~/.dotfiles/nvim ~/.config/nvim
ln -sf ~/.dotfiles/starship.toml ~/.config/starship.toml

if [[ -n "$SSH_CLIENT" || -n "$SSH_TTY" ]]; then
	# Running in remote shell, load only remote shell configs
	. "$HOME/.remote_shell_configs"
else
	# Running in local shell, load all configs
	export IN_LOCAL_SHELL=true
	. "$HOME/.local_shell_configs"
	. "$HOME/.remote_shell_configs"
fi

if [ -n "$BASH_VERSION" ]; then
    eval "$(starship init bash)"
elif [ -n "$ZSH_VERSION" ]; then
    eval "$(starship init zsh)"
fi
