# S3 Static Website Hosting Script

This project provides a shell script to host a static "Hello World" website with a cool cat image on an Amazon S3 Bucket. The S3 Bucket is created using Terraform as an Infrastructure as Code (IaC) solution.

## Table of Contents
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#Installation)
- [Clenup](#Cleanup)

## Features
- `create_infrastructure.sh`: Creates an S3 bucket in the specified region and configures the bucket for public access using Terraform.
- `host_website.sh`: Uploads `index.html`, `style.css`, and `cat_image.png` files to the bucket.
- `destroy_infrastructure.sh`: Cleans up resources and deletes the S3 bucket using Terraform.

## Prerequisites
Ensure the following prerequisites are met before start installing the project:

- **AWS CLI** installed and configured with appropriate permissions.
- **Terraform** installed.
- **Shell environment** (Linux/macOS).

## Installation
1. Clone The Repository:
```sh
git clone https://github.com/DavidKoterlan/S3-Static-Website-Hosting-Script.git
cd S3-Static-Website-Hosting-Script
```

2. Make Scripts Executable:
```sh
chmod +x create_infrastructure.sh
chmod +x host_website.sh
chmod +x destroy_infrastructure.sh
```

3. Configure Terraform Variables:
Create a file named `terraform.tfvars` in the `infrastructure directory`. Use `terraform.tfvars.example` as a template to specify:

- aws_profile: AWS profile Terraform will use.
- bucket_name: Name of the S3 Bucket to be created.
- bucket_region: AWS region where the bucket will be located.

4. Create Infrastructure:
Run the following command to create the S3 Bucket:

```sh
./create_infrastructure.sh
```
5. Host Website:
Upload necessary files (`index.html`, `style.css`, `cat_image.png`) to the S3 Bucket using:

```sh
./host_website.sh
```
Expected output:
```sh
You have posted a static webpage with the following url: 
https://<name-of-the-bucket>.s3.<region>.amazonaws.com/index.html
```

Visit the URL to view the "Hello World" page with the cool cat image.

# Cleanup
After enjoying the webpage, cleanup resources to avoid unnecessary AWS costs.

Run the following script to delete the S3 Bucket and associated resources:

```sh
./destroy_infrastructure.sh
```
