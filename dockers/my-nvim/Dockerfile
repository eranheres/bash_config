# Use the Ubuntu LTS base (22.04 at the time of writing)
FROM ubuntu:22.04

# Avoid interactive prompts during package installation
# ENV DEBIAN_FRONTEND=noninteractive

# Update packages and install what you need
RUN apt-get update 
RUN apt-get install -y zsh git curl fzf wget gcc python3 python3-pip ripgrep 
RUN apt-get install -y cron

RUN git config --global user.email "dockernvim@eran.com"
# Get my repos
RUN --mount=type=secret,id=git,env=GITHUB_TOKEN \ 
    git clone https://$(echo $GITHUB_TOKEN | tr -d '\n')@github.com/eranheres/nvim-obsidian.git ~/.config/nvim-obsidian
RUN --mount=type=secret,id=git,env=GITHUB_TOKEN \ 
    git clone https://$(echo $GITHUB_TOKEN | tr -d '\n')@github.com/eranheres/bash_config.git ~/bash_config


RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
RUN tar -C /opt -xzf nvim-linux64.tar.gz
# (Optional) Set zsh as the default shell
SHELL ["/usr/bin/zsh", "-c"]
#
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerlevel10k theme
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k && \
    sed -i 's/ZSH_THEME="[^"]*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc


# Install lazygit
ENV LAZYGIT_VERSION=v0.44.1
RUN curl -LO https://github.com/jesseduffield/lazygit/releases/download/v0.44.0/lazygit_0.44.0_Linux_x86_64.tar.gz
RUN tar xf lazygit_0.44.0_Linux_x86_64.tar.gz lazygit
RUN install lazygit -D -t /usr/local/bin/

RUN echo 'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' >>! ~/.zshrc
# Create a soft link for Powerlevel10k configuration
RUN ln -s ~/bash_config/p10k.zsh ~/.p10k.zsh
RUN echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> ~/.zshrc
RUN echo 'source /root/bash_config/zsh_profile.zsh' >> ~/.zshrc
RUN echo 'export SECOND_BRAIN_DIR="/root/second-brain"' >> ~/.zshrc
RUN echo 'alias obs="cd /root/second-brain;  NVIM_APPNAME=nvim-obsidian nvim ."' >> ~/.zshrc
RUN export SECOND_BRAIN_DIR="/root/second-brain"
# Update all nvim packages
RUN NVIM_APPNAME=nvim-obsidian /opt/nvim-linux64/bin/nvim --headless '+Lazy! sync' +qa
RUN NVIM_APPNAME=nvim-obsidian /opt/nvim-linux64/bin/nvim --headless '+Lazy! sync' +qa

# Cron to update git
RUN echo "* * * * * python3 /root/bash_config/dockers/my-nvim/obs_push.py /root/second-brain >> /var/log/cron.log 2>&1" > /etc/cron.d/my-cron-job
RUN chmod 0644 /etc/cron.d/my-cron-job
RUN crontab /etc/cron.d/my-cron-job
RUN touch /var/log/cron.log


# Set zsh as the entry point
WORKDIR /root
CMD /bin/bash -c "cron && /root/bash_config/dockers/my-nvim/init_docker.sh && exec /bin/zsh"
#CMD ["/bin/zsh", "-c", "/root/bash_config/dockers/my-nvim/init_docker.sh && exec /bin/zsh"]
#ENTRYPOINT "/bin/zsh"

