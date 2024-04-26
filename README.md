# bash_config

## Installation
This is the installation guide for the bash configuration. 
It is assumed that the repository is cloned.

### zsh
#### 1. Install p10k
```bash
TODO
```

#### 2. Install zsh personalization
```bash
# check if profile is already sourced and source it if not
grep -q "source $(pwd)/zsh_profile" ~/.zshrc || echo "source $(pwd)/zsh_profile" >> ~/.zshrc
```

### Regular bash
This installation assumes that the repository is cloned to `~/bash_config`.
```bash
echo "source $(pwd)/profile" >> ~/.bashrc
echo "\$include $(pwd)
```

