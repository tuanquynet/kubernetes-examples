
## create namespace
kubectl create  namespace jenkins

## add repo for jenkins
helm repo add jenkins https://charts.jenkins.io

helm repo update

##  edit jenkins helm chart
helm  inspect values  jenkins/jenkins > ./jenkins/values.yaml

## install helm jenkins chart
helm install my-jenkins jenkins/jenkins --values ./jenkins/values.yaml --namespace jenkins 

# Wait for around 1 minute
sleep 10

## start tunnel for jenkins service
## print out admin's password in jenkins
kubectl exec --namespace jenkins -it svc/my-jenkins -c jenkins -- /bin/cat /run/secrets/chart-admin-password && echo

## check services
kubectl get service

# NOTES: 32323
## forward port
kubectl --namespace jenkins port-forward svc/my-jenkins 8080:32323

## open on browser
http://localhost:8080


## setup local registry
