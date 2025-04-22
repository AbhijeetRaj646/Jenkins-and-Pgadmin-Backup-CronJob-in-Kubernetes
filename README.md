# ☁️ Kubernetes Backup Automation

This repository contains Kubernetes manifests and scripts to automate backup for two critical components:

1. **Jenkins Backup**
2. **PostgreSQL Database Backup (via pgAdmin)**

Each component runs in its own environment using Kubernetes CronJobs, Docker containers, ConfigMaps, and Secrets to schedule and manage backups securely.

---

## 📁 Project Structure

```
.
├── Jenkins Script/
│   ├── Dockerfile                         # Custom image for Jenkins backup
│   ├── aws-credentials-secret.yaml       # AWS credentials for S3
│   ├── backup-script.sh                  # Jenkins backup script
│   ├── jenkins-backup-configmap.yaml     # ConfigMap with S3 bucket name
│   ├── jenkins-backup-cronjob.yaml       # CronJob to perform backup
│   ├── jenkins-deployment.yaml           # Jenkins deployment
│   ├── jenkins-service.yaml              # Service to expose Jenkins
│   ├── postgres-deployment.yaml          # PostgreSQL used by Jenkins
│   ├── pv.yaml                            # Persistent Volume for Jenkins
│   ├── role.yaml                          # Role for backup permissions
│   └── service-account.yaml              # ServiceAccount for RBAC
├── pgAdmin Script/
│   ├── Dockerfile                         # Custom image for DB backup
│   ├── aws-credentials-secret.yaml       # AWS credentials for S3
│   ├── backup-script-database.sh         # PostgreSQL DB backup script
│   ├── database-backup-cronjob.yaml      # CronJob for DB backup
│   ├── database_configmap.yaml           # ConfigMap with DB/S3 info
│   ├── postgres-deployment.yaml          # PostgreSQL deployment
│   ├── role.yaml                          # Role for DB backup
│   └── service-account.yaml              # ServiceAccount for DB backup
└── README.md
```

---

## 🚀 Setup Instructions

### 1. Jenkins Backup

```bash
cd "Jenkins Script"

# Apply Kubernetes resources
kubectl apply -f pv.yaml
kubectl apply -f jenkins-deployment.yaml
kubectl apply -f jenkins-service.yaml
kubectl apply -f aws-credentials-secret.yaml
kubectl apply -f jenkins-backup-configmap.yaml
kubectl apply -f role.yaml
kubectl apply -f service-account.yaml
kubectl apply -f jenkins-backup-cronjob.yaml
```

### 2. PostgreSQL Backup via pgAdmin

```bash
cd "pgAdmin Script"

# Apply Kubernetes resources
kubectl apply -f postgres-deployment.yaml
kubectl apply -f aws-credentials-secret.yaml
kubectl apply -f database_configmap.yaml
kubectl apply -f role.yaml
kubectl apply -f service-account.yaml
kubectl apply -f database-backup-cronjob.yaml
```

---

## 🧰 Prerequisites

- Kubernetes Cluster (Minikube, EKS, GKE, etc.)
- `kubectl` configured
- AWS S3 Bucket (for storing backups)
- AWS access key and secret in `aws-credentials-secret.yaml`

---

## 🔐 Security Note

Avoid hardcoding credentials in manifests. Use Kubernetes Secrets (`aws-credentials-secret.yaml`) to store sensitive data securely.

---

## 📦 Docker Images

Each script uses a Dockerfile to build a custom image with required tools:
- `aws-cli`
- `kubectl`
- `bash`

Make sure to build and push the image to your container registry, or reference it directly in the CronJob YAML.

---

## 📅 Backup Scheduling

Backups are scheduled using Kubernetes **CronJobs**, configurable with the `schedule` field in:

- `jenkins-backup-cronjob.yaml`
- `database-backup-cronjob.yaml`

---

## 🧹 Cleanup

To remove all resources:

```bash
kubectl delete -f ./
```

Run this inside both `Jenkins Script/` and `pgAdmin Script/` folders.

---

## 📬 Contributions

Feel free to open issues or submit pull requests if you'd like to improve or extend this setup.

---



