#!/bin/bash

sudo apt-get update
sudo apt-get install zsh curl tree vim htop unzip git python3-pip net-tools

git clone git@github.com:pchmielowski/dotfiles.git

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
rm .zshrc
ln -s dotfiles/.zshrc
mkdir ~/.trash

echo '[include]'                       >> ~/.gitconfig
echo '    path = dotfiles/.gitconfig'  >> ~/.gitconfig
