## Reference docs
- https://www.youtube.com/watch?v=QoDqxm7ybLc&list=PLy7NrYWoggjziYQIDorlXjTvvwweTYoNC&index=18
- sample code: https://gitlab.com/nanuchi/youtube-tutorial-series/-/blob/master/prometheus-exporter/install-prometheus-commands.md

## Prerequisite
- setup local development environment with minikube
- configure auto reload for local dev using 

### Start minikube
- minikube start --cpus 2 --memory 4096 --vm-driver hyperkit --insecure-registry "10.0.0.0/24"

### common issues
- update CRD: https://github.com/prometheus-community/helm-charts/issues/557
kubectl delete crd alertmanagerconfigs.monitoring.coreos.com
kubectl delete crd alertmanagers.monitoring.coreos.com
kubectl delete crd podmonitors.monitoring.coreos.com
kubectl delete crd probes.monitoring.coreos.com
kubectl delete crd prometheuses.monitoring.coreos.com
kubectl delete crd prometheusrules.monitoring.coreos.com
kubectl delete crd servicemonitors.monitoring.coreos.com
kubectl delete crd thanosrulers.monitoring.coreos.com

### View grafana
- forward port to grafana container (pod): `kubectl port-forward deployment.apps/prometheus-stack-grafana 3000`
- open on browser: http://localhost:3000