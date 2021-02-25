kubectl get secret mysql-secrets
kubectl describe secret mysql-secrets

kubectl get persistentvolumeclaim mysql-data-disk

kubectl describe persistentvolumeclaim mysql-data-disk

kubectl get deployment

kubectl describe deployment mysql-deployment
kubectl describe svc mysql-service


kubectl get pod
kubectl describe pod pod_name


kubectl get all

# port forward
kubectl port-forward pod_name 27018:27017

kubectl exec -it pod_name -- bash