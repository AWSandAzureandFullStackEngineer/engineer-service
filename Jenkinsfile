pipeline {
    agent any

    stages {
        stage("build"){
            steps {
                echo "----------- build started ----------"
                    sh 'export IMAGE_PATH=registry.hub.docker.com/steven8519/engineers-service:$(date +%Y%m%d%H%M%S)'
                    sh 'mvn compile com.google.cloud.tools:jib-maven-plugin:3.3.2:build -Dimage=$IMAGE_PATH -Dmaven.test.skip=true'
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
    }
}