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
                    publishChecks(name: 'Stage Reporter', status: ChecksStatus.IN_PROGRESS, summary: 'Building...')
                }
                echo "helo"
                // Mark the build as complete
                script {
                    publishChecks(name: 'Stage Reporter', conclusion: ChecksConclusion.SUCCESS, summary: 'Build completed')
                }
            }
        }

        stage('Test') {
            steps {
                echo "sleep"
                script {
                    publishChecks(name: 'Stage Reporter', conclusion: ChecksConclusion.SUCCESS, summary: 'Tests passed')
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    publishChecks(name: 'Stage Reporter', status: ChecksStatus.IN_PROGRESS, summary: 'Deploying...')
                }
                // Deploy the application
                echo "sleep"
                // Mark the deployment as complete
                script {
                    publishChecks(name: 'Stage Reporter', conclusion: ChecksConclusion.SUCCESS, summary: 'Deployment completed')
                }
            }
        }
    }
}
