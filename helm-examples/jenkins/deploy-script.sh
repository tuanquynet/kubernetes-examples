# Prerequisites
# - macos
# - minikube version: v1.15.1
# - kubectl
#   - Client Version: version.Info{Major:"1", Minor:"19", GitVersion:"v1.19.3", GitCommit:"1e11e4a2108024935ecfcb2912226cedeafd99df", GitTreeState:"clean", BuildDate:"2020-10-14T12:50:19Z", GoVersion:"go1.15.2", Compiler:"gc", Platform:"darwin/amd64"}
#   - Server Version: version.Info{Major:"1", Minor:"19", GitVersion:"v1.19.4", GitCommit:"d360454c9bcd1634cf4cc52d1867af5491dc9c5f", GitTreeState:"clean", BuildDate:"2020-11-11T13:09:17Z", GoVersion:"go1.15.2", Compiler:"gc", Platform:"linux/amd64"}
# - docker desktop: engine: v20.10.2
# - helm: v3.4.1

# install docker
# grab a installer from here https://docs.docker.com/docker-for-mac/install/

# install kuberctl
# https://kubernetes.io/docs/tasks/tools/install-kubectl/
brew install kubectl 

# install minikube
# https://minikube.sigs.k8s.io/docs/start/
brew install minikube

## remove previous minikube if any
brew cask remove minikube
brew link minikube

## check version
docker --version
minikube version
kubectl version
helm version

## start minikube
minikube start --driver=docker

## add repo for jenkins
helm repo add jenkins https://charts.jenkins.io
helm repo update
## install helm jenkins chart
helm install my-jenkins jenkins/jenkins
# Wait for around 1 minute
sleep 60
## start tunnel for jenkins service
minikube service my-jenkins
## print out admin's password in jenkins
kubectl exec --namespace default -it svc/my-jenkins -c jenkins -- /bin/cat /run/secrets/chart-admin-password && echo

## check services
kubectl get service

## forward port
kubectl --namespace default port-forward svc/my-jenkins 8080:8080

## open on browser
http://localhost:8080

## clean up helm
helm delete my-jenkins


## clean up minikube
minikube stop
# sleep 30
minikube delete