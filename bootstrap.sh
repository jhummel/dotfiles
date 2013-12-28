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

# Open Hemisu with terminal
# It's up to you to set it as a default
# I also change the font to monoco 10 and turn off antialiased text
open ./terminal/colors/Hemisu\ Dark.terminal

rsync --exclude ".git/" --exclude ".DS_Store" --exclude "*.swp" \
      --exclude "bootstrap.sh" --exclude "Brewfile" --exclude "Caskfile" \
      --exclude "OSX" --exclude "README.md" --exclude "terminal/" \
      --exclude ".gitmodules" -av --no-perms . ~

# Install Pathogen for vim, not a submodule because I don't want extra files
mkdir -p ~/.vim/autoload ~/.vim/bundle ~/.vim/colors;
curl -Sso ~/.vim/autoload/pathogen.vim \
     https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

# Install Hemisu for vim
curl -Sso ~/.vim/colors/hemisu.vim \
     https://raw.github.com/noahfrederick/vim-hemisu/master/colors/hemisu.vim

# Switch the fugly MacVim icon to something nicer
target=$(find /opt/homebrew-cask/Caskroom -name MacVim.app 2> /dev/null | sort | tail -n 1)
path="$target/Contents/Resources/"

wget -O /tmp/MacVim.icns http://dribbble.com/shots/337065-MacVim-Icon-Updated/attachments/15582
cp /tmp/MacVim.icns $path
rm /tmp/MacVim.icns

PATH="$ORIGPATH"

# Some sensible os defaults
# chmod u+x OSX
# ./OSX

