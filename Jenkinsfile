pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'echo Building...'
            }
        }
        stage('Lint HTML') {
            steps {
                sh 'tidy -q -e **/*.html'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t capstone .'
            }
        }
        stage('Push Docker Image') {
            steps {
                withDockerRegistry([url: "", credentialsId: "dockerhub_id"]) {
                    sh "docker tag capstone mantismamita/capstone"
                    sh 'docker push mantismamita/capstone'
                }
            }
        }
        stage('Deploying') {
            steps{
                echo 'Deploying to AWS...'
                withAWS(credentials: 'kirstenc', region: 'us-west-2') {
                    sh "aws eks --region us-west-2 update-kubeconfig --name capstonecluster"
                    sh "kubectl config use-context arn:aws:eks:us-west-2:618826675264:cluster/capstonecluster"
                    sh "kubectl set image deployments/capstone capstone=mantismamita/capstone:latest"
                    sh "kubectl apply -f deployment/deployment.yml"
                    sh "kubectl get nodes"
                    sh "kubectl get deployment"
                    sh "kubectl get pod -o wide"
                    sh "kubectl get service/capstone"
                }
            }
        }
        stage("Pruning") {
            steps{
                echo 'Pruning...'
                sh "docker system prune"
            }
        }
    }
}