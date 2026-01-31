#!/bin/bash

# Source git completions
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Aliases
alias vi='nvim'
alias g="git"
__git_complete g __git_main
alias icat="kitty +kitten icat"
alias pip='uv pip'
alias sc="source .venv/bin/activate"
alias s="kitty +kitten ssh"
alias shc="s edgar"
alias ak="NVIM_TREESITTER_DISABLED=true ANKI_NVIM_ENABLED=true vi /tmp/anki.md"
alias zk="cd ~/zettelkasten/; nvim"
alias dp="vi ~/personal/daily_progress.md"
alias yz="yazi"
alias l="ls -laht"
alias av='nvim -c "lua vim.defer_fn(function()require(\"avante.api\").zen_mode()end, 100)"'
alias sd="rsync -a --exclude '.git' ~/.dotfiles/"

# Environment variables
export TERM='xterm'
export EDITOR='nvim'
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbbin:$PATH"
export PATH="/opt/homebrew/anaconda3/bin:$PATH"
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.pixi/bin:$PATH"
export PATH="$HOME/.dotfiles/scripts/:$PATH"
export PATH="$HOME/usr/bin:$PATH"
export PATH="$HOME/usr/local/bin:$PATH"
export UHD_IMAGES_DIR=~/uhd_images
export MANPAGER="nvim +Man!"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


# Required for dbus session zathura integration
export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"


# Check if running in local shell (not SSH)
if [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ]; then
    export IN_LOCAL_SHELL=true
fi

# Function to change to work directory
function wd() {
    cd /Users/cmcirvin/Documents/VirginiaTech/Spring2026/
}

# Function to change to dotfiles directory
function sdf() {
    cd ~/.dotfiles
}

# Docker alias for nicely-formatted container output
function dps() {
    watch -n 1 'docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"'
}

# Function to activate virtual environment
function venv() {
    if [ -z "$1" ]; then
        echo "Error: Missing venv environment."
        echo "Usage: venv <env_name>"
        return 1
    fi

    source ~/.venvs/$1/bin/activate
}

# Function to create and setup virtual environment
function vv() {
    # Check if pyproject.toml exists, if not initialize it
    if [ ! -f "pyproject.toml" ]; then
        uv init
    fi
    uv add pynvim debugpy ruff pyright
}


function sce() {
    if [ -z "$1" ]; then
        echo "Error: Missing remote host argument."
        echo "Usage: sce <user>@<remote_host>"
        return 1
    fi

    scp ~/.env $1:~/.env
}

# Install Starship prompt if not already installed
eval "$(starship init bash)"

if [ -f .env ]; then
    . .env
fi
