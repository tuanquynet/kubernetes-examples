
# create base64-encoded user and pass
echo -n "admin" | base64
echo -n "mypassword" | base64

kubectl apply -f secret.yaml

kubectl apply -f persistent-volume.yaml

kubectl apply -f persistent-volume-claim.yaml

kubectl apply -f deployment.yaml

kubectl apply -f service.yaml

# expose service
# minikube service mongodb-service
