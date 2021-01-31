
# create master controller
kubectl create -f redis-master-deployment.yaml

kubectl get rc

kubectl get pods

# create master service
kubectl create -f redis-master-service.yaml

kubectl get services

kubectl describe services redis-master

# create slave controler
kubectl create -f redis-slave-deployment.yaml
# create slave service
kubectl create -f redis-slave-service.yaml

kubectl get services
# create frontend controler
kubectl create -f frontend-deployment.yaml

kubectl get rc

kubectl get pods
# create frontend service
kubectl create -f frontend-service.yaml

# view service
minikube service frontend --url

# scale frontend
kubectl scale deployment frontend --replicas=5