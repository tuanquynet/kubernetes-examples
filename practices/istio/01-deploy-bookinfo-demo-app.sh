# https://istio.io/latest/docs/setup/getting-started/#download
# Deploy the sample application
kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml

kubectl get pods

kubectl exec "$(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- curl -sS productpage:9080/productpage | grep -o "<title>.*</title>"

# Open the application to outside traffic
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
istioctl analyze

# Determining the ingress IP and ports
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].nodePort}')
echo "$INGRESS_PORT"
echo "$SECURE_INGRESS_PORT"
export INGRESS_HOST=$(minikube ip)
echo "$INGRESS_HOST"
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
echo "$GATEWAY_URL"
# Verify external access
echo "http://$GATEWAY_URL/productpage"

# View the dashboard
kubectl apply -f samples/addons
kubectl rollout status deployment/kiali -n istio-system
istioctl dashboard kiali
# ssh with tunnel and open http://localhost:20001/kiali
- minikube tunnel
- ssh devops@139.162.61.116 -L 20001:localhost:20001 -L 30475:<server-internal-ip:30475