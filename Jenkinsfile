pipeline {
  agent any

  options {
    timestamps()
    disableConcurrentBuilds()
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Terraform Version') {
      steps {
        sh 'terraform version'
      }
    }

    stage('Format Check') {
      steps {
        sh 'terraform fmt -check -recursive'
      }
    }

    stage('Initialize') {
      steps {
        sh 'terraform init -input=false'
      }
    }

    stage('Validate') {
      steps {
        sh 'terraform validate'
      }
    }
    
    stage('Plan') {
      steps {
        withCredentials([
          string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'),
          string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')
          ]) {
          sh 'terraform plan -input=false -no-color'
          }
        }
      }
  }
  
  post {
    always {
      archiveArtifacts artifacts: '**/terraform.lock.hcl', allowEmptyArchive: true
    }
    success {
      echo 'Terraform validation and plan completed.'
    }
    failure {
      echo 'Review the console log and correct the reported error.'
    }
  }
}
