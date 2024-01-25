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
        def retryForTimeoutExceeded(count = 3, Closure closure) {
            for (int i = 1; i <= count; i++) {
                try {
                    closure()
                    break
                } catch (FlowInterruptedException error) {
                    int retriesLeft = count - i
                    def hasTimeoutExceeded = error.causes[0].getClass().toString() == 'class org.jenkinsci.plugins.workflow.steps.TimeoutStepExecution$ExceededTimeout'
                    println "Timeout Exceeded for clousre.\nRetries left: $retriesLeft"
                    if (retriesLeft == 0 || !hasTimeoutExceeded) {
                        throw error
                    }
                }
            }
        }

        stage("Quality Gate") {
                retryForTimeoutExceeded {
                    timeout(time: 1, unit: 'MINUTES') {
                        // Just in case something goes wrong, pipeline will be killed after a timeout
                        def qg = waitForQualityGate() // Reuse taskId previously collected by withSonarQubeEnv
                        if (qg.status != 'OK') {
                            error "Pipeline aborted due to sonar quality gate failure: ${qg.status}"
                        }
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