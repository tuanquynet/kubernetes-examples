# go to ./eksworkshop/helm
helm create eksdemo

# remove created files
rm -rf ./eksdemo/templates/**/*.*
rm ./eksdemo/Chart.yaml
rm ./eksdemo/values.yaml

cat <<EoF > ./eksdemo/Chart.yaml
apiVersion: v2
name: eksdemo
description: A Helm chart for EKS Workshop Microservices application
version: 0.1.0
appVersion: 1.0
EoF

# ##
# If deployment/frontend.yaml, service/frontend.yaml,... files exist, we can skip to creating values.yaml step
# ##
mkdir -p ./eksdemo/templates/deployment
mkdir -p ./eksdemo/templates/service

# copy files from cd ecsdemo-nodejs, ecsdemo-crystal, ecsdemo-frontend
# Copy and rename frontend manifests
cp /Users/tuanquynet/research/kubernetes/eksworkshop/ecsdemo-frontend/kubernetes/deployment.yaml ./eksdemo/templates/deployment/frontend.yaml
cp /Users/tuanquynet/research/kubernetes/eksworkshop/ecsdemo-frontend/kubernetes/service.yaml ./eksdemo/templates/service/frontend.yaml

# Copy and rename crystal manifests
cp /Users/tuanquynet/research/kubernetes/eksworkshop/ecsdemo-crystal/kubernetes/deployment.yaml ./eksdemo/templates/deployment/crystal.yaml
cp /Users/tuanquynet/research/kubernetes/eksworkshop/ecsdemo-crystal/kubernetes/service.yaml ./eksdemo/templates/service/crystal.yaml

# Copy and rename nodejs manifests
cp /Users/tuanquynet/research/kubernetes/eksworkshop/ecsdemo-nodejs/kubernetes/deployment.yaml ./eksdemo/templates/deployment/nodejs.yaml
cp /Users/tuanquynet/research/kubernetes/eksworkshop/ecsdemo-nodejs/kubernetes/service.yaml ./eksdemo/templates/service/nodejs.yaml

# create values.yaml
cat <<EoF > ./eksdemo/values.yaml
# Default values for eksdemo.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

# Release-wide Values
replicas: 2
version: 'latest'

# Service Specific Values
nodejs:
  image: brentley/ecsdemo-nodejs
crystal:
  image: brentley/ecsdemo-crystal
frontend:
  image: brentley/ecsdemo-frontend
EoF


# test deployment helm charts
helm install --debug --dry-run workshop ./eksdemo

# deploy charts
helm install workshop ./eksdemo

# Expose port to access from external
kubectl --namespace default port-forward svc/ecsdemo-frontend 8080:80