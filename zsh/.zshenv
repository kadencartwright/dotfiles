ZDOTDIR=$HOME/.config/zsh
PATH=$PATH:$HOME/.local/bin
PATH="$PATH:/home/k/.cargo/bin"
SSH_AUTH_SOCK=/home/k/.bitwarden-ssh-agent.sock
. "$HOME/.cargo/env"
eval "$(atuin init zsh --disable-up-arrow)"
