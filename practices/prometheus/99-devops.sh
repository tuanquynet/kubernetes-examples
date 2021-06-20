  # port forward to grafana
kubectl port-forward deployment.apps/prometheus-stack-grafana 3000

# view values used in chart
helm show values chart_name

# port forward to Prometheus-UI container
kubectl port-forward service/prometheus-kube-prometheus-prometheus 9090

# port forward Alert Manager UI
kubectl port-forward svc/prometheus-kube-prometheus-alertmanager 9093

# port forward Grafana
kubectl port-forward deployment/prometheus-grafana 3000

# mongodb-exporter
kubectl port-forward service/mongodb-exporter-prometheus-mongodb-exporter 9216  
