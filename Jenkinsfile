pipeline{
    agent any
    environment{
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
         DOCKERHUB_CREDENTIALS = credentials('56234-dockerhub')
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
            sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
   
        } 
    }
      stage('push image') {
            steps{
                sh 'docker push 56234/ensta:$BUILD_NUMBER'
            }
        
}

    stage('Deploy'){
        steps {
            script{
                kubernetesDeploy(configs: "deployment.yml", kubeconfigId; "kubeconfig_$(params.enviornment)")
            }
        }
}
}
