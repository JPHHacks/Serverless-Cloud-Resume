# Cloud Resume Challenge - Jean Paul Heymann

## Project Overview
This project is my implementation of the Cloud Resume Challenge, a hands-on project designed to showcase cloud skills, particularly with AWS. The challenge involves creating a resume website and deploying it using various cloud services.

## Live Site

You can view the live resume here: https://jpheymann.com

## Architecture
![Terraform](https://github.com/user-attachments/assets/4a639474-7184-47f7-93a5-5fb99ec84668)



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
   - The `Website/` folder contains a React app, which serves as the static resume.
   - This is deployed to an S3 bucket created using Terraform.
   - CloudFront is used to ensure the website is delivered quickly and securely over HTTPS.

2. **Terraform**:
   - The project uses Terraform modules to manage AWS services.
   - **Environments** (`test` and `prod`) are defined separately in `terraform/environments/`.
   - Global resources, such as S3, CloudFront, Lambda, and DynamoDB, are handled via Terraform modules in `terraform/modules/`.

3. **CI/CD Pipeline**:
   - The `.github/workflows/deploy.yml` file defines a GitHub Actions workflow that automatically deploys changes.
   - Any push to the main branch triggers the workflow, which runs the Terraform commands to update AWS infrastructure.

## Setup Instructions
**Clone the repository:**

`git clone https://github.com/JPHHacks/aws-cloud-resume.git`

**Navigate to the Terraform directory:**

`cd terraform/environments/test`

**Initialize Terraform:**

`terraform init`

**Apply Terraform for the test environment**

`terraform apply -var-file=test.tfvars`

**Repeat the above steps for the prod environment if needed**

`cd ../prod`
`terraform apply -var-file=prod.tfvars`

**Website Deployment:**

The website files in the Website/ folder can be deployed to the S3 bucket created by Terraform.
CloudFront will serve the content securely over HTTPS.

## Project Challenges

**Configuring Multi-Environment Setup:** 
Setting up test and prod environments required careful planning to avoid conflicts and ensure the infrastructure could be managed independently.

**Automating Infrastructure with Terraform:**
Learning how to organize Terraform code in modules and use it effectively for both environments was a key challenge.

**Setting Up GitHub Actions CI/CD:**
Automating the deployment process using GitHub Actions required understanding how to trigger the Terraform apply on code pushes, as well as syncing the static website files with the S3 bucket.

## Future Improvements

**Add Unit Tests: For Lambda functions to ensure visitor counting works as expected.**

**Enhanced Monitoring: Integrate AWS CloudWatch to monitor errors and performance metrics.**

**Security Enhancements: Implement AWS WAF (Web Application Firewall) for additional security.**

