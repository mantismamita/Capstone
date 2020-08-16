pipeline {
     agent any
    //  stages {
    //      stage('Build') {
    //          steps {
    //              sh 'echo "Hello World"'
    //              sh '''
    //                  echo "Multiline shell steps works too"
    //                  ls -lah
    //              '''
    //          }
    //      }
    //      stage('Lint HTML') {
    //           steps {
    //               sh 'tidy -q -e *.html'
    //           }
    //      }
    //      stage('Security Scan') {
    //           steps { 
    //              aquaMicroscanner imageName: 'alpine:latest', notCompleted: 'exit 1', onDisallowed: 'fail'
    //           }
    //      }         
    //      stage('Upload to AWS') {
    //           steps {
    //               withAWS(region:'us-west-2',credentials:'aws-static') {
    //               sh 'echo "Uploading content with AWS creds"'
    //                   s3Upload(pathStyleAccessEnabled: true, payloadSigningEnabled: true, file:'index.html', bucket:'static-jenkins-pipeline')
    //               }
    //           }
    //      }
    //  }
         stages {
         stage('Build') {
              steps {
                  sh 'echo Building...'
              }
         }
         stage('Lint HTML') {
              steps {
                  sh 'tidy -q -e *.html'
              }
         }
         stage('Build Docker Image') {
              steps {
                  sh 'docker build -t capstone-devops .'
              }
         }
         stage('Push Docker Image') {
              steps {
                  withDockerRegistry([url: "", credentialsId: "docker-hub"]) {
                      sh "docker tag capstone-devops mantismamita/capstone-devops"
                      sh 'docker push mantismamita/capstone-devops'
                  }
              }
         }
         stage('Deploying') {
              steps{
                  echo 'Deploying to AWS...'
                  withAWS(credentials: 'aws', region: 'us-west-2') {
                      sh "aws eks --region us-west-2 update-kubeconfig --name capstonecluster"
                      sh "kubectl config use-context arn:aws:eks:us-west-2:988212813982:cluster/capstonecluster"
                      sh "kubectl set image deployments/capstone-devops capstone-devops=mantismamita/capstone-devops:latest"
                      sh "kubectl apply -f deployment/deployment.yml"
                      sh "kubectl get nodes"
                      sh "kubectl get deployment"
                      sh "kubectl get pod -o wide"
                      sh "kubectl get service/capstone-devops"
                  }
              }
        }
}