#!/bin/bash

if [ $# -eq 1 ] && [[ $1 == *i* ]]; then
  sudo apt update
  sudo apt install \
    chrome-gnome-shell \
    gitk \
    gnome-tweak-tool \
    python3 \
    python3-pip \
    vim \
    zsh
  chsh -s $(which zsh)
fi

if [ $# -eq 1 ] && [[ $1 == *d* ]]; then
  DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  ln -s $DIR/.zshrc ~/.zshrc
  ln -s $DIR/.zsh_alias ~/.zsh_alias
  ln -s $DIR/.gitconfig ~/.gitconfig
  ln -s $DIR/.flake8 ~/.flake8
  mkdir -p ~/.ipython/profile_default/startup
  ln -s $DIR/50-import.py ~/.ipython/profile_default/startup/50-import.py
  ln -s $DIR/ipython_config.py ~/.ipython/profile_default/ipython_config.py
fi

if [ $# -eq 1 ] && [[ $1 == *s* ]] && ! sudo grep -q "$USER ALL=(ALL) NOPASSWD:ALL" /etc/sudoers; then
  echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers > /dev/null
  sudo cp se /usr/share/X11/xkb/symbols/se
  setxkbmap -layout se -variant nodeadkeys
fi
