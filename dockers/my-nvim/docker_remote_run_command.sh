gcloud compute ssh my-nvim -- -t "docker exec -it \$(docker ps -q | head -n 1) /bin/zsh"
