# Refer to https://helm.sh/docs/chart_template_guide/getting_started/

```bash
helm create mychart
rm -rf mychart/templates/*
touch mychart/templates/configmap.yaml
```
- add below content to mychart/templates/configmap.yaml
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: mychart-configmap
data:
  myvalue: "Hello World"
```

- install chart
```bash
helm install full-coral ./mychart
```