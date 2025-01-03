# Use the Ubuntu LTS base (22.04 at the time of writing)
FROM ubuntu:22.04

# Avoid interactive prompts during package installation
# ENV DEBIAN_FRONTEND=noninteractive

# Update packages and install what you need
RUN apt-get update && apt-get install -y \
    zsh \
    python3 python3-pip \
    neovim \
    git curl \
    fzf \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# (Optional) Set zsh as the default shell
SHELL ["/usr/bin/zsh", "-c"]

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerlevel10k theme
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k && \
    sed -i 's/ZSH_THEME="[^"]*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

RUN --mount=type=secret,id=git,env=GITHUB_TOKEN \ 
    git clone https://$(echo $GITHUB_TOKEN | tr -d '\n')@github.com/eranheres/second-brain.git ~/second-brain

RUN --mount=type=secret,id=git,env=GITHUB_TOKEN \ 
    git clone https://$(echo $GITHUB_TOKEN | tr -d '\n')@github.com/eranheres/nvim-obsidian.git ~/nvim-obsidian

RUN --mount=type=secret,id=git,env=GITHUB_TOKEN \ 
    git clone https://$(echo $GITHUB_TOKEN | tr -d '\n')@github.com/eranheres/bash_config.git ~/nvim-obsidian

# Set zsh as the entry point
ENTRYPOINT ["/usr/bin/zsh"]

