/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install terraform kubectl 
brew install --cask brave-browser firefox vlc signal visual-studio-code ableton-live-lite docker losslesscut handbrake obs notion gimp
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## Install pip
python3 -m ensurepip --upgrade

# Add kubectl Alias
echo 'alias kc=kubectl' >> ~/.zshrc

# Add code runner aliases
echo 'alias py=python3' >> ~/.zshrc
echo 'alias python=python3' >> ~/.zshrc
echo 'alias tf=terraform' >> ~/.zshrc

# Add Encroyt & Decrypt Aliases
echo 'alias encrypt=openssl aes-256-cbc -a -salt' >> ~/.zshrc
echo 'alias decrypt=openssl aes-256-cbc -d -a' >> ~/.zshrc