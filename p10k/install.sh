## install font from artifacts 
cp '../artifacts/MesloLGS NF Regular' ~/Library/Fonts
## now install p10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
