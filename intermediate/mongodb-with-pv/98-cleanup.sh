kubectl delete -f service.yaml

kubectl delete -f deployment.yaml

kubectl delete -f persistent-volume-claim.yaml

kubectl delete -f persistent-volume.yaml

kubectl delete -f secret.yaml

# # remove folder inside minikube engine server
# minikube ssh
# sudo rm -r /mnt/data/mysql
# exit
