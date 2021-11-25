// prerequisite:
// - create file-type credential  with id localkubeconfig.file
// - the kube config  should specify default context and default cluster
// - plugins: docker pull jshimko/kube-tools-aws:3.7.0
// - images: jshimko/kube-tools-aws:3.7.0
pipeline {
    // agent {
    //     docker { image 'node:14-alpine' }
    // }
    agent any

    environment {
        AWS_DEFAULT_REGION = 'ap-southeast-1'
    }

    stages {
        stage('Deploy with helm') {
            agent {
                docker {
                    image 'jshimko/kube-tools-aws:3.7.0'
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
                    withCredentials([file(credentialsId: 'awskubeconfig.file', variable: 'KUBECRED')]) {
                       sh 'mkdir  -p ~/.kube'
                       sh 'cat $KUBECRED > ~/.kube/config'
                    }
                    withCredentials([file(credentialsId: 'aws-config.file', variable: 'AWS_PROFILE_DATA')]) {
                       sh 'mkdir  -p ~/.aws'
                       sh 'cat $AWS_PROFILE_DATA > ~/.aws/config'
                    }
                    withCredentials([usernamePassword(credentialsId: 'aws-key-secret', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    //   sh 'aws ec2 describe-instances  --query "Reservations[].Instances[].InstanceId"'
                      sh 'helm repo add hello https://www.kleinloog.ch/hello-helm/'
                      sh 'helm repo update'
                      sh 'helm install my-hello hello/hello -n default'
                    }
                }
            }
        }
    }
}
