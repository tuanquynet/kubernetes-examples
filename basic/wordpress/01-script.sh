# It will load kustomization.yaml and all resource defined inside it
kubectl apply -k ./

# expose service
minikube service wordpress --url