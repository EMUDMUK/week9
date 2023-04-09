podTemplate(yaml: '''
    apiVersion: v1
    kind: Pod
    spec:
     containers:
     - name: cloud-sdk
       image: google/cloud-sdk:latest
       command:
       - sleep
       args:
       - 9999999
       volumeMounts:
       - name: shared-storage
         mountPath: /mnt
       - name: google-cloud-key
         mountPath: /var/secrets/google
       env:
       - name: GOOGLE_APPLICATION_CREDENTIALS
         value: /var/secrets/google/kubernetes-382610-4168665f94f4.json
     restartPolicy: Never
     volumes:
     - name: shared-storage
       persistentVolumeClaim:
         claimName: jenkins-pv-claim
     - name: google-cloud-key
       secret:
         secretName: sdk-key
''') {
node(POD_LABEL) {
   stage('Deploying to prod') {
    container('cloud-sdk') {
      stage('Build a calculator project') {
        sh '''
        echo 'namespaces in the staging environment'
        kubectl get ns
        gcloud auth login --cred-file=$GOOGLE_APPLICATION_CREDENTIALS
        gcloud projects list
        gcloud config set project kubernetes-382610
        gcloud container clusters get-credentials hello-cluster --region us-west1 
        echo 'namespaces in the prod environment'
        git 'https://github.com/EMUDMUK/week9.git'
        kubectl apply -f hazelcast.yaml -n prod
        kubectl apply -f calculator.yaml -n prod
        
'''
}
}
}
   stage('Testing Service Sum') {
    container('cloud-sdk') {
      stage('Testing calculator project') {
        sleep 90
        sh "chmod +x smoke-test.sh && ./smoke-test.sh"
}
}
}
}
}
