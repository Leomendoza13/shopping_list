#!/bin/bash
set -e

PROJECT_ID="recrutement-polyconseil"
REGION="europe-west1"
IMAGE_NAME="europe-west1-docker.pkg.dev/${PROJECT_ID}/shopping-list-repo-dev/app:latest"

cd terraform/env/dev/setup/
terraform init
terraform apply
cd ../
terraform init
terraform apply -target=module.storage.google_artifact_registry_repository.shopping_list_repo

cd ../../../


docker build -t ${IMAGE_NAME} .


gcloud auth configure-docker europe-west1-docker.pkg.dev
docker push ${IMAGE_NAME}


cd terraform/env/dev/
terraform apply

#SERVICE_URL=$(terraform output -raw service_url)
