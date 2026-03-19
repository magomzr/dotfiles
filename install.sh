#!/bin/bash

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

echo "Creating symlinks..."

# Vim
ln -sf "$DOTFILES/.vimrc" "$HOME/.vimrc"

# Neovim
if [ -d "$HOME/.config/nvim" ] && [ ! -L "$HOME/.config/nvim" ]; then
  cp -r "$HOME/.config/nvim" "$HOME/.config/nvim.backup"
  echo "nvim.backup created"
fi
rm -rf "$HOME/.config/nvim"
ln -sf "$DOTFILES/nvim" "$HOME/.config/nvim"

# Shell functions
if ! grep -q "dotfiles/shell/functions.sh" "$HOME/.zshrc" 2>/dev/null; then
  echo "source ~/dotfiles/shell/functions.sh" >> "$HOME/.zshrc"
fi
if ! grep -q "dotfiles/shell/functions.sh" "$HOME/.bashrc" 2>/dev/null; then
  echo "source ~/dotfiles/shell/functions.sh" >> "$HOME/.bashrc"
fi

echo "Done."
