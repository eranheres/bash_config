## if parameter provided, set it as github token otherwise use the default one
if [ -z "$1" ]; then
  REPO_TOKEN=$(cat ~/.ssh/github-token.txt)
else
  REPO_TOKEN=$1
fi
gcloud compute instances create-with-container my-nvim \
  --container-image docker.io/eranheres1/my-nvim:latest \
  --container-restart-policy always \
  --container-stdin --container-tty \
  --address=35.232.155.126 \
  --container-env GITHUB_TOKEN=$REPO_TOKEN
