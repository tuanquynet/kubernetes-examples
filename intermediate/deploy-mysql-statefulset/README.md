## Inspired from http://theartofit.org/how-to-create-a-mysql-deployment-in-kubernetes-using-persistent-nfs-storage/

## Preparation
- setup NFS on ubuntu: https://ubuntu.com/tutorials/install-and-configure-samba#4-setting-up-user-accounts-and-connecting-to-share
- with minikube, we need to create directory
  - minikube ssh
  - mkdir /home/docker/k8s-example