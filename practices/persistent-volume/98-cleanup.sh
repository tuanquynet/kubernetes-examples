kubectl delete -f pod.yaml

kubectl delete -f persistent-volume-claim.yaml

kubectl delete -f persistent-volume.yaml



minikube ssh
sudo rm -r /mnt/data
# exit minikube environment
exit