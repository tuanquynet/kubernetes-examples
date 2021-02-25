# create base64 value for secret value
echo -n 'david' | base64
echo -n 'password123' | base64

# create namespace
kubectl create namespace express-ingress-ns

# deploy secret
kubectl apply -f mongo-secret.yaml -n express-ingress-ns

# deploy mongodb, include Deployment and Service
kubectl apply -f mongo.yaml -n express-ingress-ns

# deploy configmap
kubectl apply -f mongo-configmap.yaml -n express-ingress-ns

# deploy mongo-express
kubectl apply -f mongo-express.yaml -n express-ingress-ns

sleep 120

# apply ingress
kubectl apply -f mongo-ingress.yaml -n express-ingress-ns

# expose service with minikube
# minikube service mongo-express-service -n express-ingress-ns