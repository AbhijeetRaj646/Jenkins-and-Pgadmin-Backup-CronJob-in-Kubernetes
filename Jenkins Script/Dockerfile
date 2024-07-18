# Use an official base image with necessary tools
FROM ubuntu:latest

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
        curl \
        tar \
        gzip \
        jq \
        unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm awscliv2.zip && \
    rm -rf ./aws

# Copy your backup script into the image
COPY backup-script.sh /usr/local/bin/backup-script.sh

# Create log directory and file
RUN mkdir -p /var/log && \
    touch /var/log/backup.log

# Set executable permissions for the script
RUN chmod +x /usr/local/bin/backup-script.sh

# Set the script as the entry point
ENTRYPOINT ["/usr/local/bin/backup-script.sh"]

#docker build -t my-local-image:latest .

