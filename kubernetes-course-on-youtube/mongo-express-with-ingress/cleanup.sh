kubectl delete -f mongo-express.yaml -n express-ingress-ns

kubectl delete -f mongo-secret.yaml -n express-ingress-ns

kubectl delete -f mongo.yaml  -n express-ingress-ns

kubectl delete -f mongo-configmap.yaml  -n express-ingress-ns

kubectl delete namespace express-ingress-ns