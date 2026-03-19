#!/bin/bash

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

echo "Creating symlinks..."

# Vim
ln -sf "$DOTFILES/.vimrc" "$HOME/.vimrc"

# Neovim
ln -sf "$DOTFILES/nvim" "$HOME/.config/nvim"

# Zsh
ln -sf "$DOTFILES/.zshrc" "$HOME/.zshrc"

# Bash
ln -sf "$DOTFILES/.bashrc" "$HOME/.bashrc"

echo "Done."
