kubectl get pv task-pv-volume

kubectl get pvc task-pv-claim

kubectl get pod task-pv-pod

# go into container
kubectl exec -it pod_name -- /bin/bash
