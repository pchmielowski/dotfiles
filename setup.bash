#!/bin/bash

sudo apt-get update
sudo apt-get install zsh curl tree vim htop unzip git net-tools
# sudo apt-get install python3-pip npm gradle # Additional.

git clone git@github.com:pchmielowski/dotfiles.git

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
rm .zshrc
ln -s dotfiles/.zshrc
mkdir ~/.trash

# TODO: Populate ~/.gitconfig with .gitconfig.example
