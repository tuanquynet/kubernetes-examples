kubectl delete -f service.yaml --namespace=wordpress

kubectl delete -f deploy.yaml --namespace=wordpress

kubectl delete -f secret.yaml --namespace=wordpress

kubectl delete -f persistent-volume-claim.yaml --namespace=wordpress

kubectl delete -f persistent-volume-host-path.yaml --namespace=wordpress

# remove namespace
# kubectl delete namespace wordpress
