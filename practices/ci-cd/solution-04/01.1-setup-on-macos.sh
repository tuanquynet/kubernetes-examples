
# Refer to https://www.jenkins.io/doc/book/installing/docker/

## Environment
- MacOS Bigsur, 11.2.
- Docker Desktop:
  - 3.5.2
  - Docker engine: 20.10.7
  - docker compose: 1.29.2
  - Kubernetes: 1.21.2

## Notes
- About docker we use docker in docker  approach

# Build custom jenkins image
cd jenkins && docker build -t myjenkins:2.289.2 .

# create docker network
docker network create jenkins

# prepare folder for jenkin home
mkdir -p /Users/quytran/jenkins/jenkins_home


# setup jenkins docker for did
docker run --name jenkins-docker --detach \
  --privileged --network jenkins --network-alias docker \
  --env DOCKER_TLS_CERTDIR=/certs \
  --volume jenkins-docker-certs:/certs/client \
  --volume /Users/quytran/jenkins/jenkins_home:/var/jenkins_home \
  --volume $(pwd)/dind-resolv.conf:/etc/resolv.conf \
  --publish 2376:2376 docker:dind --storage-driver overlay2

# run jenkins via docker
docker run \
  --name jenkins \
  --detach \
  --network jenkins \
  --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client \
  --env DOCKER_TLS_VERIFY=1 \
  --publish 8080:8080 \
  --publish 50000:50000 \
  --volume /Users/quytran/jenkins/jenkins_home:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  myjenkins:2.289.2

# Print Jenkins password
docker exec -ti jenkins cat /var/lib/jenkins/secrets/initialAdminPassword
