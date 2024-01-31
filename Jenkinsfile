pipeline {
    agent any

    stages {
        stage("build"){
            steps {
                echo "----------- build started ----------"
                    sh ' export IMAGE_PATH=registry.hub.docker.com/steven8519/engineer-service:$(date +%Y%m%d%H%M%S)'
                    sh 'mvn clean install com.google.cloud.tools:jib-maven-plugin:3.3.2:build -Dimage=$IMAGE_PATH  -Dmaven.test.skip=true -X'
                echo "----------- build completed ----------"
            }
        }
        stage("test")   {
            steps   {
                echo "----------- unit test started ----------"
                    sh 'mvn test surefire-report:report'
                echo "----------- unit test Completed ----------"
            }
        }

        stage('SonarQube analysis') {
            environment {
                scannerHome = tool 'sonar-scanner'
            }
            steps   {
                withSonarQubeEnv('sonarqube-server') {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }
        stage("Docker Build and Push") {
            steps {
                sh 'docker buildx build --push --platform linux/amd64 --tag steven8519/engineer-service:20240130174849 .'
            }
        }
        stage('K8S Deploy') {
            steps {
                script {
                    withKubeConfig([credentialsId: 'K8S', serverUrl: '']) {
                        sh ('kubectl apply -f  deployment.yml')
                    }
                }
            }
        }
        stage('K8S Service') {
            steps {
                script {
                    withKubeConfig([credentialsId: 'K8S', serverUrl: '']) {
                        sh ('kubectl apply -f service.yml')
                    }
                }
            }
        }
    }
}