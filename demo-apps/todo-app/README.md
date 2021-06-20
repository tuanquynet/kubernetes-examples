## ROADMAP
- setup local development environment with minikube
- configure auto reload for local dev using 

# TODO with Kubernetes

## Setup development environment
- install minikube
- install local registry. For local, we can use insecure registry by starting minikube with --insecure-registry (minikube start --insecure-registry)

### Enable local registry:
notes: Registry addon on with docker uses 49154 please use that instead of default 5000
- reference doc: https://dev.to/rohansawant/how-to-setup-a-local-docker-registry-with-kubernetes-on-windows-includes-1-hidden-step-that-official-docs-doesn-t-320f
- `minikube addons enable registry`
- enable insecure connection: `minikube start --insecure-registry "10.0.0.0/24"`
- forward port to internal minikube registry:
  - `docker run --name forward-port --network=host alpine ash -c "apk add socat && socat TCP-LISTEN:49154,reuseaddr,fork TCP:$(minikube ip):49154"`
  - `kubectl port-forward --namespace kube-system $(kubectl get po -n kube-system | grep registry- | grep -v registry-proxy | \awk '{print $1;}') 49154:49154`

