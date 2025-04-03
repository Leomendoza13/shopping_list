# Shopping List API - Serverless Deployment on Google Cloud

This project provides a serverless API for managing a shopping list. The application is containerized using Docker and deployed on Google Cloud Run. Infrastructure is managed with Terraform to ensure minimal cost and reduced maintenance.

## Project Overview

This API allows users to:

1. Add an item to the shopping list.
2. Remove an item from the shopping list.
3. View the current shopping list.

## Architecture Overview

A high-level overview of the architecture:

- **Cloud Storage** stores the Terraform state.
- **Artifact Registry** stores the Docker image.
- **Cloud Run** hosts the containerized application, ensuring scalability and availability.
- **Cloud SQL** (PostgreSQL) stores the shopping list persistently.

## Project Structure

```
.
├── LICENSE
├── Makefile
├── README.md
├── dockerfile
├── requirements.txt
├── src
│   └── app.py
└── terraform
    ├── env
    │   ├── dev
    │   │   ├── backend.tf
    │   │   ├── cloud_run.tf
    │   │   ├── example.tfvars
    │   │   ├── iam.tf
    │   │   ├── main.tf
    │   │   ├── provider.tf
    │   │   ├── setup
    │   │   │   ├── state_bucket.tf
    │   │   │   ├── variables.tf
    │   │   │   └── versions.tf
    │   │   ├── storage.tf
    │   │   ├── variables.tf
    │   │   └── vpc.tf
    │   ├── prod
    │   │   └── main.tf
    │   └── staging
    │       └── main.tf
    └── modules
        ├── cloudrun
        │   ├── main.tf
        │   ├── outputs.tf
        │   └── variables.tf
        ├── iam
        │   ├── main.tf
        │   ├── outputs.tf
        │   └── variables.tf
        ├── network
        │   ├── main.tf
        │   ├── outputs.tf
        │   └── variables.tf
        └── storage
            ├── main.tf
            ├── outputs.tf
            └── variables.tf
```

## Prerequisites

- **Google Cloud Platform** account with billing enabled.
- **gcloud CLI** installed and configured.
- **Terraform** installed on your machine.
- **Docker** installed for local development.

## Setup Instructions

### Step 1: Clone the Repository

```bash
git clone git@github.com:Leomendoza13/shopping_list.git
cd shopping_list
```

### Step 2: Configure GCloud CLI

1. Install [gcloud CLI](https://cloud.google.com/sdk/docs/install) if it’s not already installed.

2. Authenticate with Google Cloud:

```bash
gcloud auth application-default login
```

This will generate an URL in your CLI, click on it, and log in to your Google Cloud account.

3. Set the project ID:

```bash
gcloud config set project recrutement-polyconseil
```

4. And then activate the neccessary api:

```bash
gcloud services enable artifactregistry.googleapis.com
gcloud services enable run.googleapis.com
gcloud services enable compute.googleapis.com
gcloud services enable vpcaccess.googleapis.com
``` 

### Step 3: Configure Terraform Variables

1. Install [Terraform](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/install-cli) if it is not already installed.

2. Create a `terraform.tfvars` file based on `example.tfvars`:

```bash
cp terraform/env/dev/example.tfvars terraform/env/dev/terraform.tfvars
```

3. Edit `terraform/env/dev/terraform.tfvars` to add your specific values:

```bash
#User to connect to the database
database_user     = "your-user"

#Password to connect to the database
database_password = "your-password"
```

### Step 4: Configure Docker

1. Install [Docker](https://docs.docker.com/engine/install/) if it is not already installed.

2. Install [Docker Desktop](https://www.docker.com/products/docker-desktop/) for windows and open it.

### Step 5: Deploy the Application

1. Deploy the application using the provided Makefile:

```bash
make
```

2. Write yes in the CLI whenever it is asked to do so.

The application takes approximately 12 minutes to deploy.

### Step 6: Using the API

1. Add an item

```bash
curl -X POST -H "Authorization: Bearer $(gcloud auth print-identity-token)" -d item=apple https://cloudrun-service-dev-676021926380.europe-west1.run.app/add_item
```

2. Remove an item

```bash
curl -X POST -H "Authorization: Bearer $(gcloud auth print-identity-token)" -d id=1 https://cloudrun-service-dev-676021926380.europe-west1.run.app/del_item
```

3. Get the Shopping List
```bash
curl -X GET -H "Authorization: Bearer $(gcloud auth print-identity-token)" https://cloudrun-service-dev-676021926380.europe-west1.run.app/get_items
```

### **Step 8: ⚠️ DON'T FORGET TO `terraform destroy` WHEN YOU ARE DONE ⚠️**

To destroy the infrastructure and avoid unnecessary costs, run the makefile rule:

```bash
make destroy
```

## TODO for V2

1. Replace Cloud SQL with Firestore
2. Use Google Secret Manager for database access
3. Add logging with Google Cloud Logging
4. Implement stronger CI/CD pipeline for automated deployments
5. Restrict database access to private network only
6. Configure backup and recovery protocols
7. Configure multiple environments (staging, production)
8. Configure service accounts with least privilege principle
9. Set up VPC connector for Cloud Run to secure internal resource
10. Implement API authentication beyond identity tokens
11. Configure alerting for system anomalies (Google Cloud Monitoring Alerting, Prometheus)
12. Implement data encryption at rest and in transit
13. Configure auto-scaling based on demand and traffic patterns
14. Configure network firewall rules to restrict traffic

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Author

Developed by Léo Mendoza. Feel free to reach out for questions, contributions, or feedback at [leo.mendoza.pro@gmail.com](mailto:leo.mendoza.pro@gmail.com).