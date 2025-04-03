# Makefile for deploying the shopping list application

PROJECT_ID := recrutement-polyconseil
REGION := europe-west1
IMAGE_NAME := $(REGION)-docker.pkg.dev/$(PROJECT_ID)/shopping-list-repo-dev/app:latest

.PHONY: all create-bucket-state create-artifact-registry build-docker-image auth-docker push-docker-image apply-dev destroy-dev destroy-bucket-state-dev destroy

# Main rule that invokes all other rules in sequence
all: create-bucket-state create-artifact-registry build-docker-image auth-docker push-docker-image apply-dev

# Create GCS bucket to store terraform state
create-bucket-state:
	cd terraform/env/dev/setup/ && terraform init && terraform apply

# Create Artifact Registry to store the Docker Image of the application
create-artifact-registry:
	cd terraform/env/dev/ && terraform init && terraform apply -target=module.storage.google_artifact_registry_repository.shopping_list_repo

build-docker-image:
	docker build -t $(IMAGE_NAME) .

# Configure Docker authentication for GCP
auth-docker:
	gcloud auth configure-docker $(REGION)-docker.pkg.dev

push-docker-image:
	docker push $(IMAGE_NAME)

# Apply remaining Terraform configuration
apply-dev:
	cd terraform/env/dev/ && terraform apply

destroy-dev:
	cd terraform/env/dev/ && terraform destroy -auto-approve

destroy-bucket-state-dev:
	cd terraform/env/dev/setup/ && terraform destroy -auto-approve

destroy: destroy-dev destroy-bucket-state-dev