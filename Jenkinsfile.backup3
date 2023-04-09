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
    stage('Deploy App to Kubernetes') {
      steps {
        container('kubectl') {
          withCredentials([file(credentialsId: 'mykubeconfig', variable: 'KUBECONFIG')]) {
          sh "kubectl cluster-info"
          sh "kubectl apply -f calculator.yaml -n staging"
        }
      }
    }
    }
}
}
