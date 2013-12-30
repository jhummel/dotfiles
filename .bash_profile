# Add local bin for all Homebrew stuff
export PATH="/usr/local/bin:$PATH"

# Add nvm shell script
source $(brew --prefix nvm)/nvm.sh

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{bash_prompt,exports,aliases,functions,extra}; do
        [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file
