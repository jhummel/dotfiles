#!/bin/sh

# Check for command line tools from Apple
# http://developer.apple.com/downloads

if ! type gcc > /dev/null 2>&1; then
  echo "You must install the command line tools from Apple"; exit 1;
fi

# Temporarily switch up the path until dotfiles are installed
# Mostly just so brew doesn't complain
ORIGPATH="$PATH"
PATH="/usr/local/bin:$PATH"
export PATH

# Installing Homebrew
# ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
# brew bundle ./Brewfile

# Install Native Apps Through Cask
# chmod u+x Caskfile
# ./Caskfile

# Install Pathogen for vim
mkdir -p ~/.vim/autoload ~/.vim/bundle;
curl -Sso ~/.vim/autoload/pathogen.vim \
     https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

rsync --exclude ".git/" --exclude ".DS_Store" --exclude "*.swp" \
      --exclude "bootstrap.sh" --exclude "Brewfile" --exclude "Caskfile" \
      --exclude "OSX" -av --no-perms . ~

PATH="$ORIGPATH"

# Some sensible os defaults
chmod u+x OSX
./OSX

