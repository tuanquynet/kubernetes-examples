# for fresh vps
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb

minikube start --cpus 2 --memory 16384 --insecure-registry "10.0.0.0/24"

minikube addons enable registry