kubectl get secret mongodb-secrets
kubectl describe secret mongodb-secrets

kubectl get persistentvolumeclaim mongodb-data-disk

kubectl describe persistentvolumeclaim mongodb-data-disk

kubectl get deployment

kubectl describe deployment mongodb-deployment
kubectl describe svc mongodb-service


kubectl get pod
kubectl describe pod pod_name


kubectl get all

# port forward
kubectl port-forward pod_name 33306:3306

kubectl exec -it pod_name -- bash