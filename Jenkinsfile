pipeline {

  environment {
    PROJECT = "sincere-chariot-264308"
    APP_NAME = "search"
    FE_SVC_NAME = "${APP_NAME}"
    CLUSTER = "cluster-1"
    CLUSTER_ZONE = "us-central1-c"
    IMAGE_TAG = "us.gcr.io/${PROJECT}/${APP_NAME}:latest"
    JENKINS_CRED = "${PROJECT}"
  }

  agent {
    kubernetes {
      label 'maventest'
      defaultContainer 'jnlp'
      yaml """
apiVersion: v1
kind: Pod
metadata:
labels:
  component: ci
spec:
  # Use service account that can deploy to all namespaces
  
  containers:
  - name: maven
    image:  us.gcr.io/halodoc-fisclouds/maven
    command:
    - cat
    tty: true
  - name: gcloud
    image: us.gcr.io/halodoc-fisclouds/gcloud
    command:
    - cat
    tty: true
  - name: helm
    image: us.gcr.io/halodoc-fisclouds/helm3
    command:
    - cat
    tty: true
"""
}
  }
  stages {
    stage('build') {
      steps {
        container('maven') {
          sh """
            mvn clean install -DskipTests
          """
        }
      }
   }
     stage('Build and push image with Container Builder') {
      steps {
        container('gcloud') {
          sh "mkdir app.jar" 
          sh "PYTHONUNBUFFERED=1 gcloud builds submit -t ${IMAGE_TAG} ."
  
        }
      } 
    }
}
 }
