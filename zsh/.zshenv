export ZDOTDIR=$HOME/.config/zsh
export PATH=$PATH:$HOME/.local/bin
export PATH="$PATH:/home/k/.cargo/bin"
export SSH_AUTH_SOCK=/home/k/.bitwarden-ssh-agent.sock
. "$HOME/.cargo/env"
eval "$(atuin init zsh --disable-up-arrow)"
## fnm config
which -s fnm &> /dev/null
if [[ $? == 0 ]] ; then
    export PATH="$HOME/.local/share/fnm:$PATH"
    eval "$(fnm env --use-on-cd)"
fi
