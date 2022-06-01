#!/bin/bash

function execute(){
  chmod +x $1;
  $1;
}

#all the dirs with an install.sh script
directories=(
./homebrew
./iterm
./oh-my-zsh
./p10k
./zsh
./vim
./nvm
./prefs
./rust
./tools
)
for dir in "${directories[@]}"; do
    execute "${dir}/install.sh";
done
