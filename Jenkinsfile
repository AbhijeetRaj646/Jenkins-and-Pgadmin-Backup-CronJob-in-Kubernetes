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
                sh 'mvn clean install'
                script {
                    publishChecks(name: 'Stage Reporter', conclusion: ChecksConclusion.SUCCESS, summary: 'Build successful')
                }
            }
            post {
                failure {
                    script {
                        publishChecks(name: 'Stage Reporter', conclusion: ChecksConclusion.FAILURE, summary: 'Build failed')
                    }
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    publishChecks(name: 'Stage Reporter', status: ChecksStatus.IN_PROGRESS, summary: 'Testing...')
                }
                // Run tests
                sh 'mvn test'
                script {
                    publishChecks(name: 'Stage Reporter', conclusion: ChecksConclusion.SUCCESS, summary: 'Tests passed')
                }
            }
            post {
                failure {
                    script {
                        publishChecks(name: 'Stage Reporter', conclusion: ChecksConclusion.FAILURE, summary: 'Tests failed')
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    publishChecks(name: 'Stage Reporter', status: ChecksStatus.IN_PROGRESS, summary: 'Deploying...')
                }
                // Deploy the application
                sh 'mvn deploy'
                script {
                    publishChecks(name: 'Stage Reporter', conclusion: ChecksConclusion.SUCCESS, summary: 'Deployment successful')
                }
            }
            post {
                failure {
                    script {
                        publishChecks(name: 'Stage Reporter', conclusion: ChecksConclusion.FAILURE, summary: 'Deployment failed')
                    }
                }
            }
        }
    }
}
