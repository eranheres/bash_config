docker buildx build --platform linux/amd64 \
  --secret id=git,src=../tokens/github-token.txt -t eranheres1/my-nvim . --push
