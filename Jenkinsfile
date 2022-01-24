import groovy.json.*
import hudson.FilePath;
import jenkins.model.*;

def dirpath = "/var/lib/jenkins/workspace/nginx-jenkins-ansible-terraform-project/terraform/static-site"

pipeline {
  agent any
  parameters {
    choice(
        name: 'Action',
        choices: "apply\ndestroy",
        description: 'Apply or Destroy the instance' )
  }
  stages {

    stage('Checkout') {
        steps {
            git branch: 'main', credentialsId: '1755868e-6441-4ac0-9b05-7bf5d0fef9a1', url: 'https://github.com/Nikunj-Ramani/nginx-jenkins-ansible-terraform.git'
        }
    }

    stage('Terraform') {
      steps {
        script {
          if (params.Action == "apply") {
            dir(dirpath){
                sh 'terraform init'
                sh 'terraform apply -var "name=webserver" -var "group=dev" -var "region=us-east-1" -var "profile=nikunjramani" --auto-approve'
            }     
          } 
          else {
            dir(dirpath){
                sh 'terraform init'
                sh 'terraform destroy -var "name=webserver" -var "group=dev" -var "region=us-east-1" -var "profile=nikunjramani" --auto-approve'
            }     
          }
        }
      }
    }

    stage('Ansible') {
      steps {
        retry(count: 5) {
          sh 'ansible-playbook -i /etc/ansible/aws_ec2.yaml ansible/static-site/site.yaml'
        }
      }
    }
  }
}
