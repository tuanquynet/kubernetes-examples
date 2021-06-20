# Prerequisite
- ubuntu 18.04
- docker-ce: 20.10.5
- 

# Install docker
sudo apt update

adduser devops
usermod -aG sudo devops
exit
# relogin

sudo apt install apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

sudo apt update

sudo apt install docker-ce

sudo systemctl status docker

sudo usermod -aG docker devops

# install kubectl https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
- curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
- sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
- kubectl version --client
