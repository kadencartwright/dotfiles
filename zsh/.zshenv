export ZDOTDIR=$HOME/.config/zsh
export PATH=$PATH:$HOME/.local/bin
export PATH="$PATH:/home/k/.cargo/bin"
export SSH_AUTH_SOCK=/home/k/.bitwarden-ssh-agent.sock
alias zed="zeditor"
. "$HOME/.cargo/env"
eval "$(atuin init zsh --disable-up-arrow)"
## fnm config
if command -v fnm >/dev/null && [ -w "${XDG_RUNTIME_DIR:-/run/user/$(id -u)}" ]; then
    export PATH="$HOME/.local/share/fnm:$PATH"
  eval "$(fnm env)"
fi
