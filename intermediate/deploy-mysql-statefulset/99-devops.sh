# get persistent volumes
kubectl get pv --namespace=wordpress

# get persistent services
kubectl get svc --namespace=wordpress

# get pods
kubectl get pod --namespace=wordpress


# debug pod
kubectl get pod mysql-5589687cb4-bbf4f --template '{{.status.initContainerStatuses}}' --namespace=wordpress

kubectl logs <pod-name>
# ex: kubectl logs mysql-5589687cb4-bbf4f

# describe service
kubectl describe svc mysqlsvc --namespace=wordpress

kubectl describe pod mysql-5589687cb4-v4ct7 --namespace=wordpress

kubectl get all --namespace=wordpress
