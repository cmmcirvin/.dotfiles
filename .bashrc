#!/bin/bash

# Aliases
alias vi=nvim
alias g="git"
alias icat="kitty +kitten icat"
alias pip='uv pip'
alias sc="source .venv/bin/activate"
alias s="kitty +kitten ssh"
alias shc="s edgar -t fish"

# Environment variables
export EDITOR='nvim'
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbbin:$PATH"
export PATH="/opt/homebrew/anaconda3/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/usr/bin:$PATH"
export PATH="$HOME/usr/local/bin:$PATH"

# Key binding (Ctrl+L to move cursor forward)
# Note: This is more complex in bash and typically handled by readline
# bind '"\C-l":forward-char'

# Check if running in local shell (not SSH)
if [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ]; then
    export IN_LOCAL_SHELL=true
fi

# Function to change to work directory
function wd() {
    cd /Users/cmcirvin/Documents/VirginiaTech/Summer2025/
}

# Function to activate virtual environment
function venv() {
    source ~/.venvs/$1/bin/activate
}

# Function to create and setup virtual environment
function vv() {
    uv venv --python 3.11.5
    printf 'export VIRTUAL_ENV=".venv"\nlayout python' > .envrc
    direnv allow
    source .venv/bin/activate
    pip install pynvim debugpy
}

# Install Starship prompt if not already installed
eval "$(starship init bash)"
