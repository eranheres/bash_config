docker pull --platform linux/amd64 eranheres1/my-nvim:latest 
docker run -it --platform linux/amd64 -e GITHUB_TOKEN=$(cat ~/.ssh/github-token.txt) eranheres1/my-nvim:latest
