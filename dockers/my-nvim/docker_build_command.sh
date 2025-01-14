docker buildx build --no-cache --platform linux/amd64 \
  --secret id=git,src=../tokens/github-token.txt -t eranheres1/my-nvim . --push
