# start minikube with insecure registry
minikube start --insecure-registry "10.0.0.0/24"

# create some folders
# minikube ssh
# mkdir -p /mnt/data/todo/nginx

# enable port forwarding
# docker run --name forward-local-registry --network=host alpine ash -c "apk add socat && socat TCP-LISTEN:5000,reuseaddr,fork TCP:$(minikube ip):5000"
docker start forward-local-registry

kubectl port-forward --namespace kube-system $(kubectl get po -n kube-system | grep registry- | grep -v registry-proxy | \awk '{print $1;}') 5000:5000


