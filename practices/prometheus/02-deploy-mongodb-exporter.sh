kubectl apply -f mongodb/deployment-service.yaml

helm install mongodb-exporter prometheus-community/prometheus-mongodb-exporter -f mongodb/mongodb-exporter-values.yaml
# or install specific version
# helm install mongodb-exporter prometheus-community/prometheus-mongodb-exporter -f mongodb/mongodb-exporter-values.yaml --version "2.8.1" 
