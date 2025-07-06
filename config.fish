alias vi=nvim
alias g="git"
alias icat="kitty +kitten icat"
alias pip='uv pip'
alias sc="source .venv/bin/activate"
alias s="kitty +kitten ssh"
alias shc="s edgar -t fish"

export EDITOR='nvim'
set -gx PATH /opt/homebrew/bin $PATH
set -gx PATH /opt/homebrew/sbbin $PATH
set -gx PATH /opt/homebrew/anaconda3/bin $PATH
set -gx PATH $HOME/.local/bin $PATH
set -gx PATH $HOME/usr/bin $PATH
set -gx PATH $HOME/usr/local/bin $PATH

bind \cf forward-char

function venv
    source ~/.venvs/$argv[1]/bin/activate.fish
end

function vv
    uv venv --python 3.11.5
    printf 'export VIRTUAL_ENV=".venv"\nlayout python' > .envrc
    direnv allow
    source .venv/bin/activate.fish
    pip install pynvim debugpy
end

# Install Starship prompt if not already installed
starship init fish | source
