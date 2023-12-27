# DevOps-Assessment-Test
## Overview
This project is dedicated to provisioning Google Kubernetes Engine (GKE) on the Google Cloud Platform, deploying a Python application using Terraform as Infrastructure as Code (IAC), implementing CI with GitHub Actions, utilizing Python Django for the application, and orchestrating continuous deployment (CD) through ArgoCD.

## Table of Contents
1. Install Required Tools
2. Terraform Setup
3. Dockerizing the Application
4. Continuous Deployment 
5. Configure GitHub Actions for Docker Hub

## Install Required Tools
### Terraform
Install Terraform by following the instructions <a href="https://developer.hashicorp.com/terraform/install?product_intent=terraform">here.</a>
### Google Cloud SDK
Install the Google Cloud SDK by following the instructions <a href="https://cloud.google.com/sdk/docs/install">here.</a>
### Docker
Install Docker by following the instructions <a href="https://docs.docker.com/engine/install/">here.</a>
### GitHub Actions
No installation required. GitHub Actions is integrated into GitHub repositories.

### ArgoCD
Install ArgoCD on GKE by following the instructions <a href="https://argo-cd.readthedocs.io/en/stable/getting_started/">here.</a>
 
 ## Terraform Setup
 ### Step 1: You Can Clone my Repository
 <code>
https://github.com/Emmylong1/DevOps-Assessment-Test.git
</code>

### Step 2: Set up Google Cloud Credentials
<code>
gcloud auth application-default login
</code>

### Step 3: Configure Terraform Variables
Copy terraform.tfvars.example to terraform.tfvars and fill in the required variables.
### Step 4: Initialize and Apply Terraform Configuration
<code>
terraform init
terraform apply OR
terraform apply -auto-approve
</code>

### Step 5: Review and Confirm
Review the proposed changes and type 'yes' to apply them. OR
-auto-approve flag with terraform apply to automatically apply changes without requiring manual confirmation.

### Step 6: Verify GKE Cluster
Check the GKE cluster on the Google Cloud Console.

## Dockerizing the Application
### Step 1: Create Dockerfile
Create a Dockerfile in your application root:
<code>
FROM python:3.8

WORKDIR /app

COPY requirements.txt requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

ENTRYPOINT ["python", "manage.py"]

CMD ["runserver", "0.0.0.0:8000"]
</code>

### Step 2: Build Docker Image
<code>
docker build -t emmylong1/devops-interview:v1 .<image_name of your choice> 
</code>

## Step 3: Verify Docker Image
<code>
docker images
</code>

## Continuous Integration (CI)
### GitHub Actions Workflow
Create .github/workflows/ci-pipeline.yml:
<code>
name: CI Pipeline

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout Repository
      uses: actions/checkout@v2

    - name: Set up Python
      uses: actions/setup-python@v2
      with:
        python-version: '3.x' # Specify your desired Python version

    - name: Build Docker Image
      run: |
        docker build -t emmylong1/devops-interview:v1 .
      env:
        DOCKER_BUILDKIT: 1

    - name: Push to Docker Hub
      run: |
        echo "${{ secrets.DOCKER_HUB_ACCESS_TOKEN }}" | docker login -u "${{ secrets.DOCKER_HUB_USERNAME }}" --password-stdin
        docker push emmylong1/devops-interview:v1
</code>

## GitHub Secrets
Add these secrets to your GitHub repository:
.'DOCKERHUB_TOKEN': Docker Hub access token
.'<dockerhub-username>': Your Docker Hub username

## Verify Continuous Integration
Make changes, push to main, and check GitHub Actions for successful deployment to your dockerhub repository.

## ArgoCD Webhook Configuration
1. Access the ArgoCD UI.
2. Go to the application you want to set up webhooks for.
3. Navigate to the "Settings" tab.
4. Under "Automation," find the "Webhook" section.
Click "Add Webhook."
4. Configure the webhook details, including the GitHub repository URL and secret.
5. Save the webhook configuration.

## ArgoCD Automatic Sync Configuration
1. Access the ArgoCD UI.
2. Go to the application you want to automatically sync.
3. Navigate to the "Settings" tab.
4. Under "Auto-Sync," enable automatic synchronization.
5. Configure the desired sync options.
6. Save the configuration

 Once you create this app, Argo CD will be ready to monitor your repo and automatically make changes to the cluster.
 Let’s see it in action!
  <a href="https://medium.com/@emmanuelibok505/github-actions-and-argo-cd-to-establish-a-gitops-workflow-76736e3a9bf2/">medium.</a>
 

## For Conclusion
This [](README.md) is to provide you Guide lines for you to implement infrastructure with Terraform, Dockerized your app, implemented continuous integration and deployment (CI/CD) with GitHub Actions and ArgoCD, and pushed the Docker image to Docker Hub. For details and troubleshooting, refer to documentation and tooling guides. The application will be automatically synced and deployed to the Kubernetes namespace called "prod" whenever changes are pushed to the main branch. 
Thank you.