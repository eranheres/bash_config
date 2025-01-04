set -x
gcloud compute ssh my-nvim \
  --zone us-central1-b \
  --command='echo "docker exec -it \$(docker ps -q | head -n 1) /bin/zsh -c ./bash_config/dockers/my-nvim/run_obs.sh" > ~/obs.sh'
