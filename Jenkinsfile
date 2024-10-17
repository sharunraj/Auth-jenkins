pipeline {
    agent any

    tools {
        maven 'my-maven'
        jdk 'JDK 21'
    }

    stages {
        stage('Clone') {
            steps {
                git url: 'https://github.com/sharunraj/Auth-jenkins.git', branch: 'main'
            }
        }
//Test file
        stage('Pre-Build') {
            steps {
                script {
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                        // Pre-build Docker cleanup steps
                        bat '''
                        docker stop authentication-sr || true
                        docker rm authentication-sr || true
                        docker rmi -f authentication-sr:latest || true
                        '''
                    }
                }
            }
        }

        stage('Build') {
            steps {
                bat "mvn clean install "
            }
        }
        stage('Create Docker Network') {
             steps {
                script {
                    // Create a Docker network, ignore errors if it already exists
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                        bat 'docker network create my-network || echo "Network already exists"'
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                bat "docker build -t authentication-sr ."
                bat "docker run --network my-network -p 8090:8090 -d --name authentication-sr authentication-sr"
            }
        }
    }
}
