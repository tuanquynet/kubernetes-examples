# Add a Cluster role binding 
kubectl create clusterrolebinding cluster-admin-binding \
 --clusterrole=cluster-admin --user=<your email associated with the k8s provider account>

git clone https://github.com/kubernetes/kube-state-metrics.git kube-state-metrics
kubectl apply -f kube-state-metrics/examples/standard

# Check to see if kube-state-metrics is running 
kubectl get pods --namespace=kube-system -l app.kubernetes.io/name=kube-state-metrics

# Clone the Elastic examples GitHub repo 
git clone https://github.com/elastic/examples.git
cd examples/beats-k8s-send-anywhere