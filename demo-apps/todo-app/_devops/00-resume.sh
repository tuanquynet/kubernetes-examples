# goto k8s folder
cd k8s

kubectl apply -f configmap.yaml
kubectl apply -f secret.yaml
kubectl apply -f persistent-volume.yaml
kubectl apply -f persistent-volume-claim.yaml

kubectl apply -f todo-webapp-deployment.yaml
kubectl apply -f todo-webapp-service.yaml

kubectl apply -f mongodb-deployment.yaml
kubectl apply -f mongodb-service.yaml

