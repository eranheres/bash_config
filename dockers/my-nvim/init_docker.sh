cd /root/bash_config
git pull
cd /root
git clone https://$(echo $GITHUB_TOKEN | tr -d '\n')@github.com/eranheres/second-brain.git ~/second-brain
/bin/zsh
