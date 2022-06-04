pipeline{
    environment{
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        imagename = "56234/ensta"
        registryCredential = '56234-github'
    }
agent any
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
            sh ('docker build -t 56234/ensta .')
        } 
    }
    stage('push'){
        steps{
            script {
                docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
                    dockerImage.push("$BUILD_NUMBER")
                    dockerImage.push('latest')
                }
            }  
            
        }
} 

    stage('Deploy'){
        steps {
            sh 'kubectl apply -f deployment.yml'
            }
        }
}
}
