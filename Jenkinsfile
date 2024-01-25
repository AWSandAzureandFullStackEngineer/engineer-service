pipeline {
    agent any

    stages {
        stage("build"){
            steps {
                echo "----------- build started ----------"
                    sh 'mvn clean install -X -Dmaven.test.skip=true'
                echo "----------- build complted ----------"
            }
        }
        stage("test")   {
            steps   {
                echo "----------- unit test started ----------"
                    sh 'mvn surefire-report:report'
                echo "----------- unit test Complted ----------"
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
        stage ("SonarQube Gatekeeper") {
                   STAGE_NAME = "SonarQube Gatekeeper"

                   if (BRANCH_NAME == "develop") {
                      echo "In 'develop' branch, skip."
                   }
                   else { // this is a PR build, fail on threshold spill
                      def qualitygate = waitForQualityGate()
                      if (qualitygate.status != "OK") {
                         error "Pipeline aborted due to quality gate coverage failure: ${qualitygate.status}"
                      }
                   }
          }
        stage("Docker Build and Push") {
            steps {
                sh ' docker buildx build --push --platform linux/amd64 --tag steven8519/engineer-service:20240119182704 .'
            }
        }
    }
}