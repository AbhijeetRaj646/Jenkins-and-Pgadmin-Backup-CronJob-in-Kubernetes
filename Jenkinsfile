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
                    // Publish a check indicating the build is in progress
                    publishChecks(name: 'Build', status: 'IN_PROGRESS', summary: 'Building...')
                }
                echo "Building the project..."
                script {
                    // Mark the build stage as successful
                    publishChecks(name: 'Build', conclusion: 'SUCCESS', summary: 'Build completed')
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Publish a check indicating the test stage is in progress
                    publishChecks(name: 'Test', status: 'IN_PROGRESS', summary: 'Running tests...')
                }
                echo "Running tests..."
                script {
                    // Mark the test stage as successful
                    publishChecks(name: 'Test', conclusion: 'SUCCESS', summary: 'Tests passed')
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Publish a check indicating the deploy stage is in progress
                    publishChecks(name: 'Deploy', status: 'IN_PROGRESS', summary: 'Deploying...')
                }
                echo "Deploying the application..."
                script {
                    // Mark the deploy stage as successful
                    publishChecks(name: 'Deploy', conclusion: 'SUCCESS', summary: 'Deployment completed')
                }
            }
        }
    }

    post {
        always {
            script {
                // Publish a final check after the pipeline has completed
                publishChecks(
                    name: 'Completed sssssucceee', 
                    title: 'Pipeline Check', 
                    summary: 'Check through pipeline', 
                    text: 'You can publish checks in the pipeline script.',
                    detailsURL: 'https://github.com/jenkinsci/checks-api-plugin#pipeline-usage',
                    actions: [[label: 'an-user-request-action', description: 'Actions allow users to request pre-defined behaviors', identifier: 'an-unique-identifier']]
                )
            }
        }
    }
}
