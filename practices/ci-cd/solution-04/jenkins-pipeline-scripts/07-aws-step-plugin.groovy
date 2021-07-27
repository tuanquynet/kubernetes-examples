// prerequisite:
// - jenkins slave already have docker 
// - jenkins agent will reuse docker.sock, docker cli from the slave
// - git repo : https://github.com/tuanquynet/playjenkins
// plugin: aws steps
pipeline {
    agent any
    stages {
        stage('Test docker') {
          steps  {
            sh 'docker  --version'
          }
        }

        stage('build and  push image') {
          steps  {
            script{
              git url: "https://github.com/tuanquynet/playjenkins"
            }
            withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-bridgetek-creds', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
              docker.withRegistry('https://298080379523.dkr.ecr.ap-southeast-1.amazonaws.com', 'aws-quy-tran-cred-id') {
                def customImage = docker.build("testing-image-01:0.0.1")
                /* Push the container to the custom Registry */
                customImage.push()
              }
            }
          }
        }
    }
}
