export PATH=$HOME/bin:$HOME/go/bin:$PATH
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
export MANPAGER='nvim +Man!'
setopt appendhistory

## setup dependencies if not installed
function install_if_not_already(){
    if [ -f "/etc/arch-release" ]; then
        if $(pacman -Q | grep -q "$1"); then
        else
            yay -S $1 --noconfirm
        fi
    fi
}
# add plugins to install here
plugins=starship,zsh-autosuggestions,zsh-completions
for plugin in $(echo $plugins | sed "s/,/ /g") 
do
    install_if_not_already $plugin
done
# enable fish like autosuggestions and history search  if installed
if test -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
fi

if test -f /opt/homebrew/bin/brew; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
## fnm config
which -s fnm &> /dev/null
if [[ $? == 0 ]] ; then
    export PATH="$HOME/.local/share/fnm:$PATH"
    eval "$(fnm env --use-on-cd)"
fi
which -s starship &> /dev/null
if [[ $? == 0 ]] ; then
    # init starship prompt
    export STARSHIP_CONFIG=~/.config/starship/starship.toml
    eval "$(starship init zsh)"
fi

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
# create a zkbd compatible hash; to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
include () {
    [[ -f "$1" ]] && source "$1"
}

include $HOME/export-esp.sh 

# cargo 
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
source "$HOME/.cargo/env"
alias docker='$(which podman)'
export EDITOR=$(which nvim)
export VISUAL=$(which nvim)
