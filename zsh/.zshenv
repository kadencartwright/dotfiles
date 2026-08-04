export ZDOTDIR=$HOME/.config/zsh
export PATH=$PATH:$HOME/.local/bin
export PATH="$PATH:/home/k/.cargo/bin"
alias zed="zeditor"
[ -r "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
eval "$(atuin init zsh --disable-up-arrow)"
## fnm config
if command -v fnm >/dev/null && [ -w "${XDG_RUNTIME_DIR:-/run/user/$(id -u)}" ]; then
    export PATH="$HOME/.local/share/fnm:$PATH"
  eval "$(fnm env)"
fi
