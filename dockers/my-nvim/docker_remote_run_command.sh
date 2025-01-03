gcloud compute ssh my-ubuntu-lts --command="docker attach $(docker ps -q | head -n 1)"
