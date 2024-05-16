# S3 Static Website Hosting Script

This project provides a **bash script** to create an S3 bucket, configure it to host a static hello world website with a cool cat image, and upload the necessary files.

## Table of Contents
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#Installation)

## Features
- Creates an S3 bucket in a specified region.
- Configures the bucket for public access.
- Sets a bucket policy to allow public read access.
- Uploads `index.html`, `style.css`, and `cat_image.png` files to the bucket.
- Provides a URL to access the hosted static website.

## Prerequisites
- **AWS CLI** installed and configured with appropriate permissions.
- Bash shell environment.

## Installation
1. Clone the repository to your local machine:
```bash
git clone https://github.com/DavidKoterlan/S3-Static-Website-Hosting-Script.git
cd S3-Static-Website-Hosting-Script
```
2. Make the script executable:
```bash
chmod +x host-website.bash
```
3. Run the script:
```bash
./host-website.bash
```

You will be prompted to enter the name of the bucket you want to create and the specified region. The script will generate a **config directory** with **bucket-policy.json** and **public-access-block.json** files, create an S3 bucket, and upload the necessary files.

The output should be something like this:

```bash
You have posted a static webpage with the following url: 
https://<name-of-the-bucket>.s3.<region>.amazonaws.com/index.html
```
