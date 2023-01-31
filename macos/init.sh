/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install brave-browser firefox vlc signal visual-studio-code sublime-text zoomus 
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Add Encroyt & Decrypt Aliases
alias encrypt="openssl aes-256-cbc -a -salt"
alias decrypt="openssl aes-256-cbc -d -a"