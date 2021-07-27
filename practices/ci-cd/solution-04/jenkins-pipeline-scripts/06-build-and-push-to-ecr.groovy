// prerequisite:
// - jenkins slave already have docker 
// - jenkins agent will reuse docker.sock, docker cli from the slave
// - git repo : https://github.com/tuanquynet/playjenkins
pipeline {
    // agent {
    //     docker { image 'node:14-alpine' }
    // }
    agent any
    stages {
        stage('Test docker') {
          steps  {
            sh 'docker  --version'
          }
        }

        stage('docker in docker') {
          agent {
              docker { 
                image 'node:14-alpine'
                args  '''
                  -v /var/run/docker.sock:/var/run/docker.sock
                  -v /usr/bin/docker:/usr/bin/docker
                '''
              }
          }
          steps  {
            sh 'docker  --version'
          }
        }

        stage('build and  push image') {
          steps  {
            script  {
              git url: "https://github.com/tuanquynet/playjenkins"
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
