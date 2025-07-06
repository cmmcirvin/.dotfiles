if test -n "$SSH_CLIENT" -o -n "$SSH_TTY"
    source "$HOME/.remote_shell_configs"
else
    set -gx IN_LOCAL_SHELL true
    source "$HOME/.local_shell_configs"
    source "$HOME/.remote_shell_configs"
end

starship init fish | source
