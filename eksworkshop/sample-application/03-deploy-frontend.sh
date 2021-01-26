cd /Users/tuanquynet/research/kubernetes/eksworkshop/ecsdemo-frontend
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml

sleep 60

# port forward to access to service
kubectl --namespace default port-forward svc/ecsdemo-frontend 8080:80

# open webapp on browser
# http://localhost:8080