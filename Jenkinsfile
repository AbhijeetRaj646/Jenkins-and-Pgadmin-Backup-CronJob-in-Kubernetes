pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                withChecks('Build') {
                    // Publish a check indicating the build is in progress
                    publishChecks(name: 'Build', status: 'IN_PROGRESS', summary: 'Building...')
                    
                    echo "Building the project..."
                    
                    // Perform build steps here
                    // Example: sh 'make build'

                    // Mark the build stage as successful
                    publishChecks(name: 'Build', conclusion: 'SUCCESS', summary: 'Build completed')
                }
            }
        }

        stage('Test') {
            steps {
                withChecks('Test') {
                    // Publish a check indicating the test stage is in progress
                    publishChecks(name: 'Test', status: 'IN_PROGRESS', summary: 'Running tests...')
                    
                    echo "Running tests..."
                    
                    // Perform test steps here
                    // Example: sh 'make test'

                    // Mark the test stage as successful
                    publishChecks(name: 'Test', conclusion: 'SUCCESS', summary: 'Tests passed')
                }
            }
        }

        stage('Deploy') {
            steps {
                withChecks('Deploy') {
                    // Publish a check indicating the deploy stage is in progress
                    publishChecks(name: 'Deploy', status: 'IN_PROGRESS', summary: 'Deploying...')
                    
                    echo "Deploying the application..."
                    
                    // Perform deploy steps here
                    // Example: sh 'make deploy'

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
                withChecks('Final Check') {
                    publishChecks(
                        name: 'example', 
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
}
