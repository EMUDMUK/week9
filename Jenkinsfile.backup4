pipeline {
  agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        spec:
          containers:
          - name: kubectl
            image: joshendriks/alpine-k8s
            command:
            - /bin/cat
            tty: true  
        '''
    }
  }
  stages {
    stage('Setting image to hello-kaniko:0.5') {
      steps {
        container('kubectl') {
          withCredentials([file(credentialsId: 'mykubeconfig', variable: 'KUBECONFIG')]) {
          sh "kubectl set image deployment/calculator-deployment calculator=dlambrig/hello-kaniko:0.5 -n staging"
        }
      }
    }
    }
    stage('Testing division for hello-kaniko:0.5') {     
       steps {
        container('kubectl') {
          withCredentials([file(credentialsId: 'mykubeconfig', variable: 'KUBECONFIG')]) {
           sleep 60
           sh "chmod +x smoke-test.sh && ./smoke-test.sh"
          }
        }
      }
    }
     stage('Setting image to hello-kaniko:1.0') {
      steps {
        container('kubectl') {
          withCredentials([file(credentialsId: 'mykubeconfig', variable: 'KUBECONFIG')]) {
          sh "kubectl set image deployment/calculator-deployment calculator=dlambrig/hello-kaniko:1.0 -n staging"
        }
      }
    }
    }
    stage('Testing division for hello-kaniko:1.0') {     
       steps {
        container('kubectl') {
          withCredentials([file(credentialsId: 'mykubeconfig', variable: 'KUBECONFIG')]) {
           sleep 60
           sh "chmod +x smoke-test.sh && ./smoke-test.sh"
          }
        }
      }
    }
}
}
