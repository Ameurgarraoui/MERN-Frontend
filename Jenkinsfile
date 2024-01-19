pipeline {
    agent any
    
    environment {
        REPO_URL = 'https://github.com/Ameurgarraoui/MERN-Frontend.git'
        DOCKERHUB_USERNAME = credentials('dockerhub_cred')
        DOCKERHUB_PASSWORD = credentials('dockerhub_cred')
        SONARQUBE_TOKEN = credentials('SonarQube')
        SONARQUBE_URL = 'http://localhost:9000'  // Adjust based on your SonarQube server URL
    }

    stages {
        
      stage('Checkout') {
            steps {
                script {
                    // Clone the React app from GitHub
                    checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: REPO_URL]]])
                }
            }
        }

        stage('SonarQube Analysis') {
    steps {
        script {
            // Change to the project directory
            dir('client') {
                withSonarQubeEnv('SonarQube') {
                    // Install dependencies and run SonarQube analysis
                    sh 'npm install'
                    sh "npm run sonar -Dsonar.host.url=${SONARQUBE_URL} -Dsonar.login=${SONARQUBE_TOKEN}"
                }
            }
        }
    }
}



        stage('Build React App') {
            steps {
                dir('client') {
                script {
                    sh 'npm install'
                    sh 'npm run build'
                    }
                 }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image and tag it
                    sh "docker build -t ameurx1/mern-app:${env.BUILD_ID} ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Log in to Docker Hub
                    withCredentials([usernamePassword(credentialsId: 'dockerhub_cred', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                        sh "docker login -u ${DOCKERHUB_USERNAME} -p ${DOCKERHUB_PASSWORD}"
                    }

                    // Push Docker image to Docker Hub
                    sh "docker push ameurx1/mern-app:${env.BUILD_ID}"
                }
            }
        }
    }

   
}
