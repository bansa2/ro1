pipeline{
    agent any
    environment{
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        dockerhub = credentials('docker-hub-5623')
    }

stages{
   stage('Checkout'){
        steps{
            checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/bansa2/ro1.git']]])
        }
    }
    stage('terraform init'){
        steps{
            sh ('terraform init')
        }
    }  
    stage('terraform validate'){
        steps{
            sh ('terraform validate')
        }
    } 
    stage('terraform plan'){
        steps{
            sh ('terraform plan')
        }
    } 
    stage('terraform Apply'){
        steps{
              sh ('terraform apply --auto-approve')
        }
    }
    stage('build'){
        steps {
            sh 'docker build -t 56234/ensta:$BUILD_NUMBER .'
        } 
    }
    stage('login to docker'){
        steps {
            sh 'echo $dockerhub_PSW docker login -u $dockerhub_USR --password-stdin'
            sh 'docker push 56234/ensta:$BUILD_NUMBER'
   
        } 
    }
    

    stage('Deploy'){
        steps {
            sh 'kubectl apply -f deployment.yml'
            }
        }
}
}
