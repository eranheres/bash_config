## if parameter provided, set it as github token otherwise use the default one
if [ -z "$1" ]; then
  REPO_TOKEN=$(cat ../tokens/github-token.txt)
else
  REPO_TOKEN=$1
fi
gcloud compute instances create-with-container my-nvim \
  --zone us-central1-b \
  --container-image docker.io/eranheres1/my-nvim:latest \
  --container-restart-policy never \
  --container-stdin --container-tty \
  --network-tier=STANDARD \
  --address=35.209.132.104 \
  --container-env GITHUB_TOKEN=$REPO_TOKEN

gcloud compute ssh my-nvim \
  --zone us-central1-b \
  --command='echo "docker exec -it \$(docker ps -q | head -n 1) /bin/zsh -c ./bash_config/dockers/my-nvim/run_obs.sh" > ~/obs'
