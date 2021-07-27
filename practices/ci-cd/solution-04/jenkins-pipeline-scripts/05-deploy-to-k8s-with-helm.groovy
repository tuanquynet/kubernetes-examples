// prerequisite:
// - create file-type credential  with id localkubeconfig.file
// - the kube config  should specify default context and default cluster
 
pipeline {
    // agent {
    //     docker { image 'node:14-alpine' }
    // }
    agent any
    stages {
        stage('Deploy with helm') {
            agent {
                docker {
                    image 'alpine/helm:3.6.3'
                    args '''
                        -u root:root
                        --network host
                        -i --entrypoint= -v $JENKINS_HOME/helm-apps:/apps -w /apps 
                        -v $HOME/.helm:/root/.helm 
                        -v $JENKINS_HOME/shared-data/.config/helm:/root/.config/helm 
                        -v $JENKINS_HOME/shared-data/.cache/helm:/root/.cache/helm 
                        '''
                }
            }
            steps {
                script  {
                    withCredentials([file(credentialsId: 'localkubeconfig.file', variable: 'KUBECRED')]) {
                       sh 'mkdir  -p ~/.kube'
                       sh 'cat $KUBECRED > ~/.kube/config'
                       sh 'kubectl get all -n jenkins'
                    }
                }
                sh 'helm repo add bitnami https://charts.bitnami.com/bitnami'
                sh 'helm repo update'
                sh 'helm install my-nginx bitnami/nginx'
            }
        }
    }
}
