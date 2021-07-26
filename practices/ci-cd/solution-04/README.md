# CI/CD with Jenkins pipeline
- jenkins will run in docker container via docker-compose
- jenkins pipeline


## Install docker on ubuntu (linux)


##  Setup Jenkins via docker compose
- For mac refer to 01.1-setup-on-macos.sh
- For Ubuntu refer to 01.2-setup-on-ubuntu.sh

### Install plugins
- Open jenkins  (http://localhost:8080)
- Go to Manage Jenkins
- Install ThinBackup
- Copy jenkins/backup folder into jenkins machine
- Config ThinBackup to point to backup folder
- Select Restore

## Build in docker container
- install Docker pipeline plugin: https://www.jenkins.io/doc/book/pipeline/docker/
- sample script:
```
pipeline {
    agent {
        docker { image 'node:14-alpine' }
    }
    stages {
        stage('Test') {
            steps {
                sh 'node --version'
            }
        }
    }
}
```


## Some default hostname
- host.docker.internal
- kubernetes.docker.internal
