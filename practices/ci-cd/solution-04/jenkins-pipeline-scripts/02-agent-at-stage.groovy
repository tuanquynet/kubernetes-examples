// we define agent at pipeline level
// and then at stage level, we can custom agent to use different one
pipeline {
    // agent {
    //     docker { image 'node:14-alpine' }
    // }
    agent any
    stages {
        stage('Test') {
            steps {
                sh 'echo "inside master agent"'
                sh 'node --version'
                sh 'mkdir -p $HOME/helm-apps'
                sh 'ls $HOME/helm-apps'
            }
        }
        stage('Run some task in python') {
            agent {
                docker {
                    image 'python:3.7.4'
                }
            }
            steps {
                sh 'python --version'
            }
        }
    }
}
