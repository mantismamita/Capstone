pipeline {
    agent any
    stages {
        stage('Lint HTML') {
            steps {
                sh 'tidy -q -e **/*.html'
            }
        }
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker Image...'
                sh 'docker build -t capstone:0.1.1 .'
            }
        }
        stage('Push Docker Image') {
            steps {
                withDockerRegistry([url: "", credentialsId: "dockerhub_id"]) {
                    sh "docker tag capstone mantismamita/capstone:0.1.1"
                    sh 'docker push mantismamita/capstone:0.1.1'
                }
            }
        }
        stage('Deploying') {
            steps{
                echo 'Deploying to AWS...'
                withAWS(credentials: 'kirstenc', region: 'us-west-2') {
                    sh "aws eks --region us-west-2 update-kubeconfig --name capstonecluster"
                    sh "kubectl get svc"
                    sh "kubectl config use-context arn:aws:eks:us-west-2:618826675264:cluster/capstonecluster"
                    sh "kubectl set image deployments/capstone-deployment nginx=mantismamita/capstone:0.1.1"
                    sh "kubectl apply -f deployment.yml"
                    sh "kubectl get nodes"
                    sh "kubectl get deployment"
                    sh "kubectl get pod -o wide"
                    sh "kubectl get service/capstone-service"
                }
            }
        }
        stage('Pruning') {
            steps{
                echo "Pruning..."
                sh "docker system prune"
            }
        }
    }
}