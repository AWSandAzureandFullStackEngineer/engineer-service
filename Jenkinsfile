pipeline {
    agent any

    stages {
        stage("build"){
            steps {
                echo "----------- build started ----------"
                    sh 'mvn clean install -X -Dmaven.test.skip=true'
                echo "----------- build completed ----------"
            }
        }
        stage("test")   {
            steps   {
                echo "----------- unit test started ----------"
                    sh 'mvn surefire-report:report'
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
                sh ' docker buildx build --push --platform linux/amd64 --tag steven8519/engineer-service:20240125025201 .'
            }
        }
    }
}