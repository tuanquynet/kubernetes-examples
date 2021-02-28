## build image
docker build -t mylocal/docker-sample-app .

docker run -p 49160:8080 -d mylocal/docker-sample-app

docker tag mylocal/docker-sample-app localhost:5000/docker-sample-app

## push to local registry
docker push localhost:5000/docker-sample-app

## test deployed image
- create deployment: `kubectl create deployment docker-sample-app --image=localhost:5000/docker-sample-app`
- view logs: `kubectl logs pod_name`
