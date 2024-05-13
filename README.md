# bash_config

## Installation
This is the installation guide for a new mac computer.


clone this repository
```zsh
cd ~
mkdir -p projects
cd projects
git clone git clone https://github.com/eranheres/bash_config.git
cd bash_config
## setup of brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "# This is automatic generated file based on setup instructions\n" >> $(pwd)/zprofile
echo "# Dont change this file manually it is referenced from $(pwd)/zprofile." >> $(pwd)/zprofile
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $(pwd)/zprofile
# check if profile is already sourced and source it if not
touch ~/.zshrc
grep -q "source $(pwd)/zsh_profile" ~/.zshrc || echo "source $(pwd)/zsh_profile.zsh" >> ~/.zshrc

eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle --file=$(pwd)/Brewfile





eval ~/.zshrc
```

