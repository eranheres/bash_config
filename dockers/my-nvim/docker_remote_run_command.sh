gcloud compute ssh my-nvim --command="docker attach $(docker ps -q | head -n 1)"
