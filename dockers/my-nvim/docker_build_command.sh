docker buildx build --platform linux/amd64 --secret id=git,src=$HOME/.ssh/github-token.txt -t eranheres1/my-nvim . --push
