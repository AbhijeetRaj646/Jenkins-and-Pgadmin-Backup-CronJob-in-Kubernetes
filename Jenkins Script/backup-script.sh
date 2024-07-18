#!/bin/bash



###########################
# Author:Abhijeet Raj
#
#This script is used for the backup of jenkins
#
#Version:v1
###########################


#set -x # debug mode

# Source environment variables from the ConfigMap
NAMESPACE=$(cat /etc/config/NAMESPACE)
DEPLOYMENT_NAME=$(cat /etc/config/DEPLOYMENT_NAME)
S3_BUCKET=$(cat /etc/config/S3_BUCKET)
AWS_REGION=$(cat /etc/config/AWS_REGION)

# Define backup file name with timestamp
BACKUP_FILE="jenkins-backup.tar.gz"

# Function to log messages
log() {
    local datetime=$(date +'%Y-%m-%d %H:%M:%S')
    echo "[${datetime}] $1"
}

# Log script start
log "Starting Jenkins backup"

# Check for required tools
if ! command -v kubectl &> /dev/null || ! command -v aws &> /dev/null; then
    log "Required tools kubectl and aws-cli are not installed. Exiting."
    exit 1
fi

# Get pod name from deployment
JENKINS_POD=$(kubectl get pods -n $NAMESPACE -l app=$DEPLOYMENT_NAME -o jsonpath='{.items[0].metadata.name}')

if [ -z "$JENKINS_POD" ]; then
    log "Failed to get Jenkins pod name. Exiting."
    exit 1
fi

# Perform backup and log the process
log "Executing backup for Jenkins pod: $JENKINS_POD"
kubectl exec -n $JENKINS_NAMESPACE $JENKINS_POD -- bash -c "cd /var/jenkins_home && tar -czf - *" > $BACKUP_FILE
aws s3 cp - s3://$S3_BUCKET/$BACKUP_FILE --region $AWS_REGION

# Check if backup was successful
if [ $? -eq 0 ]; then
    log "Jenkins backup completed successfully. Backup file: $BACKUP_FILE"
else
    log "Failed to backup Jenkins. Check logs for details."
fi

# Log script end
log "Backup script execution completed"

