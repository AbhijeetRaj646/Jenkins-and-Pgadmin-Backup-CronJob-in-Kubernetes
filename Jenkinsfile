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
                    // Mark the build stage as in progress
                    publishChecks(name: 'Stage Reporter', status: 'IN_PROGRESS', summary: 'Building...')
                }
                echo "Building the project..."
                script {
                    // Mark the build stage as successful
                    publishChecks(name: 'Stage Reporter', conclusion: 'SUCCESS', summary: 'Build completed')
                }
            }
        }

        stage('Test') {
            steps {
                echo "Running tests..."
                script {
                    // Mark the test stage as successful
                    publishChecks(name: 'Stage Reporter', conclusion: 'SUCCESS', summary: 'Tests passed')
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Mark the deploy stage as in progress
                    publishChecks(name: 'Stage Reporter', status: 'IN_PROGRESS', summary: 'Deploying...')
                }
                echo "Deploying the application..."
                script {
                    // Mark the deploy stage as successful
                publishChecks name: 'example', 
                              title: 'Pipeline Check', 
                              summary: 'Check through pipeline',
                              text: 'You can publish checks in the pipeline script.',
                              detailsURL: 'https://github.com/jenkinsci/checks-api-plugin#pipeline-usage',
                              actions: [[label: 'an-user-request-action', description: 'Actions allow users to request pre-defined behaviours', identifier: 'an-unique-identifier']]
                }
            }
        }
    }

    post {
        always {
            script {
                // Add the custom publishChecks block as a post-build step
                publishChecks name: 'example', 
                              title: 'Pipeline Check', 
                              summary: 'Check through pipeline',
                              text: 'You can publish checks in the pipeline script.',
                              detailsURL: 'https://github.com/jenkinsci/checks-api-plugin#pipeline-usage',
                              actions: [[label: 'an-user-request-action', description: 'Actions allow users to request pre-defined behaviours', identifier: 'an-unique-identifier']]
            }
        }
    }
}
