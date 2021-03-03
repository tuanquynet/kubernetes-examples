cd k8s

kubectl delete -f todo-api-deployment.yaml
kubectl delete -f todo-api-service.yaml

kubectl delete -f mongodb-service.yaml

kubectl delete -f mongodb-deployment.yaml

kubectl delete -f todo-webapp-service.yaml

kubectl delete -f todo-webapp-deployment.yaml

kubectl delete -f persistent-volume-claim.yaml

kubectl delete -f persistent-volume.yaml

kubectl delete -f secret.yaml

kubectl delete -f configmap.yaml









