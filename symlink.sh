#!/bin/bash

DOTFILES="$HOME/dotfiles"

link() {
  local src="$DOTFILES/$1"
  local dst="$2"
  mkdir -p "$(dirname "$dst")"
  ln -sf "$src" "$dst"
  echo "linked: $dst"
}

link zshrc                                              ~/.zshrc
link vimrc                                              ~/.vimrc
link gitignore_global                                   ~/.config/git/ignore
link ideavimrc                                          ~/.ideavimrc
link eslintrc.json                                      ~/.eslintrc.json
link ocamlinit                                          ~/.ocamlinit
link config/ghostty/config                              ~/.config/ghostty/config
link config/cmux/cmux.json                              ~/.config/cmux/cmux.json
link config/nvim                                        ~/.config/nvim
