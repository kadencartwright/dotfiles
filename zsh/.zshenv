export ZDOTDIR=$HOME/.config/zsh
export PATH=$PATH:$HOME/.local/bin
export PATH="$PATH:/home/k/.cargo/bin"
export SSH_AUTH_SOCK=/home/k/.bitwarden-ssh-agent.sock
. "$HOME/.cargo/env"
eval "$(atuin init zsh --disable-up-arrow)"
