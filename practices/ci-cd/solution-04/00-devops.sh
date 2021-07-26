
# create folder
mkdir ~/.config/helm
mkdir ./helm-apps

# Environment:
# ~/.kube store kubeconfig for kubectl. Behind the scene helm also use kubectl to deploy resource to k8s
# ~/.helm store heml config
# Setup helm container for testing
docker run -ti --rm -v $(pwd)/helm-apps:/apps -w /apps \
  -v ~/.kube:/root/.kube -v ~/.helm:/root/.helm -v ~/.config/helm:/root/.config/helm \
  -v ~/.cache/helm:/root/.cache/helm \
  alpine/helm

# setup helm container with other image
docker run -it -d -v ~/.kube:/root/.kube dtzar/helm-kubectl

# prepare folder for helm used in pipeline
mkdir -p /Users/quytran/jenkins/jenkins_home/shared-data
mkdir -p /Users/quytran/jenkins/jenkins_home/shared-data/.config
mkdir -p /Users/quytran/jenkins/jenkins_home/shared-data/.cache
chmod 777 /Users/quytran/jenkins/jenkins_home/shared-data

# docker exec -i jenkins-docker /bin/sh -c "cat /etc/resolv.conf"