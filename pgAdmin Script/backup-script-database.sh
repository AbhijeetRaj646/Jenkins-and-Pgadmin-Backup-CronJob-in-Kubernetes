#!/bin/bash

# Source environment variables from the ConfigMap
NAMESPACE=$(cat /etc/config/NAMESPACE)
DEPLOYMENT_NAME=$(cat /etc/config/DEPLOYMENT_NAME)
S3_BUCKET=$(cat /etc/config/S3_BUCKET)
AWS_REGION=$(cat /etc/config/AWS_REGION)
DB_NAME=$(cat /etc/config/DB_NAME)
DB_USER=$(cat /etc/config/DB_USER)
DB_PASSWORD=$(cat /etc/config/DB_PASSWORD)

# Define backup file name with timestamp
BACKUP_FILE="postgres-backup-$(date +%Y%m%d-%H%M%S).sql"

# Function to log messages
log() {
    local datetime=$(date +'%Y-%m-%d %H:%M:%S')
    echo "[${datetime}] $1"
}

# Log script start
log "Starting PostgreSQL backup"

# Check for required tools
if ! command -v kubectl &> /dev/null; then
    log "kubectl is not installed or not in PATH. Exiting."
    exit 1
else
    log "kubectl is installed."
fi

if ! command -v aws &> /dev/null; then
    log "aws-cli is not installed or not in PATH. Exiting."
    exit 1
else
    log "aws-cli is installed."
fi

# Get pod name from deployment
POSTGRES_POD=$(kubectl get pods -n $NAMESPACE -l app=$DEPLOYMENT_NAME -o jsonpath='{.items[0].metadata.name}')

if [ -z "$POSTGRES_POD" ]; then
    log "Failed to get PostgreSQL pod name. Exiting."
    exit 1
fi

# Perform backup and log the process
log "Executing backup for PostgreSQL pod: $POSTGRES_POD"
kubectl exec -n $NAMESPACE $POSTGRES_POD -- bash -c "PGPASSWORD=$DB_PASSWORD pg_dump -U $DB_USER $DB_NAME" > /tmp/$BACKUP_FILE

# Check if backup was successful
if [ $? -eq 0 ]; then
    log "PostgreSQL backup completed successfully. Backup file: $BACKUP_FILE"
else
    log "Failed to backup PostgreSQL. Check logs for details."
    exit 1
fi

# Upload backup to S3
log "Uploading backup to S3 bucket: $S3_BUCKET"
aws s3 cp /tmp/$BACKUP_FILE s3://$S3_BUCKET/$BACKUP_FILE --region $AWS_REGION

# Check if upload was successful
if [ $? -eq 0 ]; then
    log "Backup uploaded to S3 successfully."
else
    log "Failed to upload backup to S3. Check logs for details."
    exit 1
fi

# Log script end
log "Backup script execution completed"

