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
        stage("Quality Gate"){
            steps {
                script {
                    timeout(time: 5, unit: 'MINUTES') {
                        def qg = waitForQualityGate()
                        if (qg.status != 'OK') {
                            error "Pipeline aborted due to quality gate failure: ${qg.status}"
                        }
                    }
                }
            }
        }
    }
}