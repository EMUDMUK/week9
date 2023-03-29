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
            sh 'kubectl cluster-info'
            sh 'kubectl apply -f hazelcast.yaml'
            sh 'kubectl apply -f calculator.yaml'
          }
        }
      }
      stage('Testing Service Sum') {     
      steps {
        container('kubectl') {
          withCredentials([file(credentialsId: 'mykubeconfig', variable: 'KUBECONFIG')]) {
            sh 'NODE_IP=$(kubectl get service/calculator-service -o jsonpath='{.spec.clusterIP}')'
            sh 'NODE_PORT=$(kubectl get svc calculator-service -o=jsonpath='{.spec.ports[0].port}')'
            sh 'curl http://${NODE_IP}:${NODE_PORT}/sum?a=1\&b=2'
          }
        }
      }
  }
}
}
