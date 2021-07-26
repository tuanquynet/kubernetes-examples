// NOTES: to run helm inside container, we need to run as  root 
//      and pass in folder .kube which typically is located in ~/.kube
pipeline {
    agent {
        docker { image 'node:14-alpine' }
    }
    stages {
        stage('Test') {
            steps {
                sh 'echo "inside master agent"'
                sh 'node --version'
                sh 'mkdir -p $HOME/helm-apps'
                sh 'ls $HOME/helm-apps'
            }
        }
        stage('Deploy with helm') {
            agent {
                docker {
                    image 'alpine/helm:3.6.3'
                    args '''
                        -u root:root
                        --network host
                        -i --entrypoint= -v $JENKINS_HOME/helm-apps:/apps -w /apps 
                        -v $JENKINS_HOME/.kube:/root/.kube
                        -v $JENKINS_HOME/.helm:/root/.helm 
                        -v $JENKINS_HOME/shared-data/.config/helm:/root/.config/helm 
                        -v $JENKINS_HOME/shared-data/.cache/helm:/root/.cache/helm 
                        '''
                }
            }
            steps {
                // sh 'ls /root/.kube'
                // sh 'helm version'
                // sh 'helm ls'
                // `helm repo add` should be executed only once
                sh 'helm repo add bitnami https://charts.bitnami.com/bitnami'
                sh 'helm repo update'
                sh 'helm install my-nginx bitnami/nginx'
            }
        }
    }
}
