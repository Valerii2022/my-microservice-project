pipeline {
    agent {
        kubernetes {
            yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:latest
    command:
    - cat
    tty: true
    volumeMounts:
    - name: kaniko-secret
      mountPath: /kaniko/.docker
  volumes:
  - name: kaniko-secret
    secret:
      secretName: regcred
"""
        }
    }

    environment {
        AWS_DEFAULT_REGION = 'us-west-2'
        ECR_REPOSITORY = 'django-app'
        AWS_ACCOUNT_ID = '281025883997' 
        IMAGE_TAG = "${env.BUILD_NUMBER}"
        IMAGE = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${ECR_REPOSITORY}:${IMAGE_TAG}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build and Push Docker Image with Kaniko') {
            steps {
                container('kaniko') {
                    sh """
                      /kaniko/executor --context=./django-app --dockerfile=./django-app/Dockerfile --destination=${IMAGE} --cleanup
                    """
                }
            }
        }

        stage('Update Helm Chart values.yaml') {
            steps {
                sh """
                yq e '.image.tag = "${IMAGE_TAG}"' -i charts/django-app/values.yaml
                """
            }
        }

        stage('Commit and Push Helm Chart Update') {
            steps {
                sh """
                git config user.email "jenkins@example.com"
                git config user.name "Jenkins CI"
                git add charts/django-app/values.yaml
                git commit -m "Update image tag to ${IMAGE_TAG}"
                git push origin main
                """
            }
        }
    }
}

