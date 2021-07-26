pipeline {
    agent any
    stages {
        stage('Example') {
            steps {
                echo 'Hello World'
                echo 'JENKINS_HOME $JENKINS_HOME'
                sh 'ls $JENKINS_HOME'
                sh 'ping -c 2 kubernetes.docker.internal'
                sh 'ping -c 2 host.docker.internal'
            }
        }
        stage('custom agent') {
            agent {
                //Create new container as jenkins agent
                docker {
                    image 'node:14-alpine'
                    // 'ping' command require '-u root:root'
                    args '-u root:root --network host'
                }
            } 
            steps {
                echo 'JENKINS_HOME $JENKINS_HOME'
                sh 'ls $JENKINS_HOME'
                // to use ping, it require root '-u root:root'
                sh 'ping -c 2 kubernetes.docker.internal'
                sh 'ping -c 2 host.docker.internal'
            }
        }
    }
    post { 
        always { 
            echo 'I will always say Hello again!'
        }
    }
}
