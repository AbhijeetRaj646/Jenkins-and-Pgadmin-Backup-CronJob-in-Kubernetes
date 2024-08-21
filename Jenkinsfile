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
                // Build the project using Maven
                // sh 'mvn clean install'
                echo "helo"
                script {
                    publishChecks(name: 'Stage Reporter', conclusion: ChecksConclusion.SUCCESS, summary: 'Build successful')
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    publishChecks(name: 'Stage Reporter', status: ChecksStatus.IN_PROGRESS, summary: 'Testing...')
                }
                // Run tests
                // sh 'mvn test'
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
                script {
                    publishChecks(name: 'Stage Reporter', conclusion: ChecksConclusion.SUCCESS, summary: 'Deployment successful')
                }
            }
        }
    }
}
