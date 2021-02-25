# create base64 value for secret value
echo -n 'david' | base64
echo -n 'password123' | base64

# deploy secret
kubectl apply -f mongo-secret.yaml

# deploy mongodb, include Deployment and Service
kubectl apply -f mongo.yaml

# deploy configmap
kubectl apply -f mongo-configmap.yaml

# deploy mongo-express
kubectl apply -f mongo-express.yaml

sleep 120

# expose service with minikube
minikube service mongo-express-service