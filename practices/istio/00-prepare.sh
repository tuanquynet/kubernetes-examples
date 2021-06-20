
# start minikube
# minikube start --cpus 2 --memory 4096 --vm-driver hyperkit --insecure-registry "10.0.0.0/24"
# on ubuntu
# minikube start --cpus 2 --memory 16384 --insecure-registry "10.0.0.0/24"

# install istio
## download istio https://istio.io/latest/docs/setup/getting-started/#download
curl -L https://istio.io/downloadIstio | sh -
cd istio-{version}
export PATH=$PWD/bin:$PATH

## install with demo profile
istioctl install --set profile=demo -y

## Add a namespace label to instruct Istio to automatically inject Envoy sidecar proxies when you deploy your application later
kubectl label namespace default istio-injection=enabled

