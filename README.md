# Cloud Resume Challenge - Jean Paul Heymann

## Project Overview
This project is my implementation of the Cloud Resume Challenge, a hands-on project designed to showcase cloud skills, particularly with AWS. The challenge involves creating a resume website and deploying it using various cloud services.

## Live Site

You can view the live resume here: https://www.jpheymann.cloud

## Architecture
![Terraform](https://github.com/JPHHacks/Serverless-Cloud-Resume/issues/1#issue-2712848535)



## Technologies Used
- Frontend: HTML, CSS, JavaScript
- Backend: AWS Lambda, API Gateway
- Database: DynamoDB
- Infrastructure as Code: Terraform
- CI/CD: GitHub Actions
- DNS: Route 53
- Content Delivery: CloudFront
- Hosting: S3
- HTTPS: AWS Certificate Manager

## How It Works

1. **Website**:
   - The `website/` folder contains a React app, which serves as the static resume.
   - This is deployed to an S3 bucket created using Terraform.
   - CloudFront is used to ensure the website is delivered quickly and securely over HTTPS.
   - The frontend uses JavaScript to call the API, which invokes AWS Lambda functions for backend operations, such as incrementing view counts and retrieving data.

3. **Terraform**:
   - The project uses Terraform to manage AWS services.
   - The `terraform/modules/` directory contains reusable modules for various AWS resources, including S3, CloudFront, Lambda, DynamoDB, Route 53, ACM, and API Gateway.
   - The production environment is defined in `terraform/env/prod/`, which includes all necessary resources for the application.
   - The `backend-setup` directory is specifically for managing the Terraform state using S3 and DynamoDB.

4. **CI/CD Pipeline**:
   - The `.github/workflows/deploy.yml` file defines a GitHub Actions workflow that automatically deploys changes.
   - Any push to the main branch triggers the workflow, which runs the Terraform commands to update AWS infrastructure.

## Setup Instructions

**1. Clone the repository:**

   `git clone https://github.com/JPHHacks/Serverless-Cloud-Resume.git`
   

**2. Setting up AWS CLI with SSO (if not already configured):**

   `aws configure sso`
   
   Follow the prompts to set up SSO for your AWS accounts

**3. Initialize Terraform:**

   Before deploying, you need to initialize Terraform in both the backend and production directories.

   - **Navigate to the Backend Setup Directory**:
     ```bash
     cd terraform/backend-setup
     terraform init
     ```

   - **Navigate to the Production Environment Directory**:
     ```bash
     cd ../env/prod
     terraform init
     ```

**4. Deploying the infrastructure:**

   Log in to AWS SSO for the production account:
   
   `aws sso login --profile prod-profile`
   
   Plan Terraform changes:
   
   `terraform plan -out=tfplan`
   
   Apply changes:
   
   `terraform apply tfplan`

   Commit and push your changes to the main branch:
   
   `git add .`
   
   `git commit -m "Description of changes"`
   
   `git push origin main`

   This will trigger the GitHub Actions workflow for deployment.               
   

## Website Deployment

The deployment of the website is automated using GitHub Actions, specifically through the `.github/workflows/deploy.yml` file. This workflow is triggered on every push to the `main` branch and performs the following tasks:

1. **Builds the React App**: It installs dependencies and builds the React application for production.
2. **Deploys to S3**: After building, it deploys the optimized app to an S3 bucket.
3. **Invalidates CloudFront Cache**: The workflow ensures that the CloudFront distribution is updated to serve the latest version of the website.

This automation simplifies the deployment process, ensuring that the live site is always up-to-date with the latest changes.

## AWS Account Management

To facilitate secure access to AWS resources, I created an AWS Organizations setup for managing SSO (Single Sign-On) user accounts. This allows for centralized management of user permissions and access across multiple AWS accounts, ensuring that users have the appropriate level of access based on their roles.

## Project Challenges

**Configuring Multi-Environment Setup:** 
Setting up test and prod environments required careful planning to avoid conflicts and ensure the infrastructure could be managed independently.

**Automating Infrastructure with Terraform:**
Learning how to organize Terraform code in modules and use it effectively for both environments was a key challenge.

**Setting Up GitHub Actions CI/CD:**
Automating the deployment process using GitHub Actions required understanding how to trigger the Terraform apply on code pushes, as well as syncing the static website files with the S3 bucket.

## Future Improvements

**Enhanced Monitoring: Integrate AWS CloudWatch to monitor errors and performance metrics.**

**Security Enhancements: Implement AWS WAF (Web Application Firewall) for additional security.**

