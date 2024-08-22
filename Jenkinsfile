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
                    recordIssues enabledForFailure: true, aggregatingResults: true, tool: pyLint(pattern: 'pylint.log'),publishChecks: true  
                    
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
}
