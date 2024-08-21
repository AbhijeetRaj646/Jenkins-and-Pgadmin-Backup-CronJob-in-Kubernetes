pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from GitHub
                checkout scm
            }
        }

        stage('Build') {
            steps {
                script {
                    // Assuming publishChecks is a custom step or function
                    publishChecks(name: 'Stage Reporter', status: 'IN_PROGRESS', summary: 'Building...')
                }
                echo "helo"
                script {
                    publishChecks(name: 'Stage Reporter', conclusion: 'SUCCESS', summary: 'Build completed')
                }
            }
        }

        stage('Test') {
            steps {
                echo "sleep"
                script {
                    publishChecks(name: 'Stage Reporter', conclusion: 'SUCCESS', summary: 'Tests passed')
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    publishChecks(name: 'Stage Reporter', status: 'IN_PROGRESS', summary: 'Deploying...')
                }
                // Deploy the application
                echo "sleep"
                script {
                    publishChecks(name: 'Stage Reporter', conclusion: 'SUCCESS', summary: 'Deployment completed')
                }
            }
        }
    }
}
