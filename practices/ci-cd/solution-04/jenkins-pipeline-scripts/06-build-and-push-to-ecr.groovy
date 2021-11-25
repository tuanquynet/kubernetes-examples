// prerequisite:
// - jenkins slave already have docker 
// - jenkins agent will reuse docker.sock, docker cli from the slave
// - git repo : https://github.com/tuanquynet/playjenkins
pipeline {
    // agent {
    //     docker { image 'node:14-alpine' }
    // }
    agent any

    environment {
      AWS_REGION = 'ap-southeast-1'
      GITCOMMIT = "${env.GIT_COMMIT}"
      AWC_ECR_REPO_ID = '298080379523'
    }

    stages {
        stage('Test docker') {
          steps  {
            sh 'docker  --version'
          }
        }

        stage('docker in docker') {
          agent {
            // scenario
            //  jenkins running in container
            //  docker-dind server with port :2376 is running in another container
            // below container will run inside docker-dind
            docker { 
              image 'docker:dind'
              args  '''
                -u root:root
                --privileged
                --network host 
                --env DOCKER_HOST=tcp://docker-dind:2376 
                --env DOCKER_CERT_PATH=/certs/client 
                -v /certs/client:/certs/client
                -i --entrypoint=''
              '''
            }
          }
          steps  {
            sh 'docker  --version'
          }
        }

        // stage('build and  push image') {
        //   steps  {
        //     script  {
        //       git url: "https://github.com/tuanquynet/playjenkins"
        //       withCredentials([file(credentialsId: 'aws-config.file', variable: 'AWS_PROFILE_DATA')]) {
        //          sh 'mkdir  -p ~/.aws'
        //          sh 'cat $AWS_PROFILE_DATA > ~/.aws/config'
        //       }
        //       withCredentials([usernamePassword(credentialsId: 'aws-key-secret', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
        //       //   sh 'aws ec2 describe-instances  --query "Reservations[].Instances[].InstanceId"'
        //         aws ecr get-login-password --region <region> --profile=default | docker login --username AWS --password-stdin <AWS user ID>.dkr.ecr.<region>.amazonaws.com
        //         docker.withRegistry('https://298080379523.dkr.ecr.ap-southeast-1.amazonaws.com') {
        //           def customImage = docker.build("testing-image-01:0.0.1")
        //           /* Push the container to the custom Registry */
        //           customImage.push()
        //         }
        //       }
        //     }

        //   }
        // }

        stage('docker get ecr token:prepare') {
          steps {
            sh 'mkdir -p ./shared'
          }
        }
        
        stage('docker get ecr token') {
          agent {
            docker { 
              image 'amazon/aws-cli'
              args  """
                -u root:root
                -i --entrypoint=''
                --network host 
                -v ${env.WORKSPACE}/shared:/root/shared
              """
            }
          }
          steps {
            withCredentials([file(credentialsId: 'aws-config.file', variable: 'AWS_PROFILE_DATA')]) {
              sh 'mkdir  -p ~/.aws'
              sh 'cat $AWS_PROFILE_DATA > ~/.aws/config'

              withCredentials([usernamePassword(credentialsId: 'aws-key-secret', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                sh 'aws ecr get-login-password --region "$AWS_REGION" > /root/shared/ecr-token'
              }
            }
          }
        }

        stage('docker build and push to ecr') {
          steps {
            script  {
              git url: "https://github.com/tuanquynet/playjenkins"
            }
            sh(label: 'ECR login and docker push', script:
               """
               #!/bin/bash
               
                  echo "Authenticate with ECR"
                  set +x # Don't echo credentials from the login command!
                  echo "Building New ECR Image"
                  # Enable Debug and Exit immediately 
                  cat ${env.WORKSPACE}/shared/ecr-token | docker login --username AWS --password-stdin https://${AWC_ECR_REPO_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
                  set -xe
                  docker build  -t ${AWC_ECR_REPO_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/testing-image-01:0.0.1 .
                  #two push one for master tag other is git commit ID
                  # docker push ${AWC_ECR_REPO_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/nginx:${GITCOMMIT}
                  docker push ${AWC_ECR_REPO_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/testing-image-01:0.0.1
                  docker tag ${AWC_ECR_REPO_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/testing-image-01:0.0.1
                  docker push ${AWC_ECR_REPO_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/testing-image-01:0.0.1
               """.stripIndent()
            )
          }
        }
    }
}
