pipeline {
    // agent {
    //     docker { image 'node:14-alpine' }
    // }
    agent any
    stages {
        // stage('Test') {
        //     steps {
        //         sh 'echo "inside master agent"'
        //         sh 'node --version'
        //         sh 'mkdir -p $HOME/helm-apps'
        //         sh 'ls $HOME/helm-apps'
        //     }
        // }
        stage('K8S get pod') {
            agent {
                docker {
                    image 'dtzar/helm-kubectl:3.6.3'
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
            }
        }
        // stage('Deploy with helm') {
        //     agent {
        //         docker {
        //             image 'alpine/helm:3.6.3'
        //             args '''
        //                 -u root:root
        //                 --network host
        //                 -i --entrypoint= -v $JENKINS_HOME/helm-apps:/apps -w /apps 
        //                 -v $JENKINS_HOME/.kube:/root/.kube -v $HOME/.helm:/root/.helm 
        //                 -v $JENKINS_HOME/shared-data/.config/helm:/root/.config/helm 
        //                 -v $JENKINS_HOME/shared-data/.cache/helm:/root/.cache/helm 
        //                 '''
        //         }
        //     }
        //     steps {
        //         // sh 'ls /root/.kube'
        //         // sh 'helm version'
        //         // sh 'helm ls'
        //         sh 'helm repo add bitnami https://charts.bitnami.com/bitnami'
        //         sh 'helm repo update'
        //         sh 'helm install my-nginx bitnami/nginx'
        //     }
        // }
    }
}
