# bash_config

## Installation
This is the installation guide for a new mac computer.


clone this repository
```bash
cd ~
mkdir -p projects
cd projects
git clone git clone https://github.com/eranheres/bash_config.git
cd bash_config
## setup of brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

## install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
grep -q "source $(pwd)/zsh_profile" ~/.zshrc || echo "source $(pwd)/zsh_profile.zsh" >> ~/.zshrc
echo "OPEN_API_KEY: YourKeyHere" >> $(pwd)/config.yml

# install nvims
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Traap/nvims/master/install.sh)"

# brew install all modules
eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle --file=$(pwd)/Brewfile

eval ~/.zshrc
```
### Fonts
Download and install into iTerm2 nerd 0xProto-Nerd-Font from here: https://www.nerdfonts.com/font-downloads

### Neovims 
install the neovims setups.
```zsh
mkdir -p ~/.config
cd ~/.config
git clone https://github.com/eranheres/nvim-general nvim-a
git clone https://github.com/eranheres/nvim-python
git clone https://github.com/eranheres/nvim-iosdev nvim-ios
```

## Run healthcheck
brew
nvims
