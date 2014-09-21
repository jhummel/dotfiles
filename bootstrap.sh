#!/bin/sh

echo "You must install the command line tools from Apple using 'xcode-select --install'. Then delete this line"; exit 1;

# Temporarily switch up the path until dotfiles are installed
# Mostly just so brew doesn't complain
ORIGPATH="$PATH"
PATH="/usr/local/bin:$PATH"
export PATH

# XQuartz
# wget -O /tmp/XQuartz-2.7.5.dmg http://xquartz.macosforge.org/downloads/SL/XQuartz-2.7.5.dmg
# hdiutil mount /tmp/XQuartz-2.7.5.dmg
# sudo installer -package /Volumes/XQuartz-2.7.5/XQuartz.pkg -target "/Volumes/Macintosh HD"
# hdiutil unmount "/Volumes/XQuartz-2.7.5"
# rm /tmp/XQuartz-2.7.5.dmg

# Installing Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew bundle ./Brewfile

# Install Native Apps Through Cask
brew bundle ./Caskfile

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
    https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim

# Install Hemisu for vim
curl -Sso ~/.vim/colors/hemisu.vim \
     https://raw.githubusercontent.com/noahfrederick/vim-hemisu/master/colors/hemisu.vim

# Switch the fugly MacVim icon to something nicer
target=$(find /opt/homebrew-cask/Caskroom -name MacVim.app 2> /dev/null | sort | tail -n 1)
path="$target/Contents/Resources/"

wget -O /tmp/MacVim.icns http://dribbble.com/shots/337065-MacVim-Icon-Updated/attachments/15582
cp /tmp/MacVim.icns $path
rm /tmp/MacVim.icns

# Install node and some global npm modules
nvm install v0.10.30
nvm alias default 0.10.30
nvm use 0.10.30

npm install -g grunt-cli yo browserify generator-generator

PATH="$ORIGPATH"

# Some sensible os defaults
chmod u+x OSX
./OSX

# Install IE VMs for Virtual Box.
# This is at the end because it's gonna take a loooooooong time
export IEVMS_VERSIONS="8 9 10 11"
curl -s https://raw.github.com/xdissent/ievms/master/ievms.sh | bash

# Clean up VM install files
find ~/.ievms -type f ! -name "*.vmdk" -exec rm {} \;
