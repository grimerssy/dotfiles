curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ~/.homebrew
eval "$(~/.homebrew/bin/brew shellenv)"
brew update --force --quiet
chmod -R go-w "$(brew --prefix)/share/zsh"
brew bundle install --global