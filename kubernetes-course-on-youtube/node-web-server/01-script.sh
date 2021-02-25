# we need to enable ingress on minikube
# But we need to use vm-based driver
#  ❌  Exiting due to MK_USAGE: Due to networking limitations of driver docker on darwin, ingress addon is not supported.
# Alternatively to use this addon you can use a vm-based driver:
# minikube addons enable ingress

# create namespace
kubectl create namespace node-web-server

# deploy secret
kubectl apply -f node-web-server.yaml -n node-web-server

sleep 120

# apply ingress
kubectl apply -f ingress.yaml -n node-web-server

# expose service with minikube
# minikube service mongo-express-service -n express-ingress-ns