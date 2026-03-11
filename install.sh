#!/bin/bash

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

echo "Creating symlinks..."

# Vim
ln -sf "$DOTFILES/.vimrc" "$HOME/.vimrc"

# Neovim
mkdir -p "$HOME/.config/nvim"
ln -sf "$DOTFILES/init.vim" "$HOME/.config/nvim/init.vim"

echo "Done."
