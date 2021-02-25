# kubectl create namespace wordpress

# apply persistent volume
# or use hostPath PV
kubectl apply -f persistent-volume-host-path.yaml

# apply persistent volume claim
kubectl apply -f persistent-volume-claim.yaml

# generate base64-encoded password, change mysqlpassword to any value you want
# echo -n 'mysqlpassword' | base64

# apply secret
kubectl apply -f secret.yaml

# apply deployment
kubectl apply -f deploy.yaml

kubectl apply -f service.yaml

# reveal service info
kubectl describe svc mysqlsvc --namespace=wordpress