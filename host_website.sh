#!/bin/sh

# Extract bucket name and URL from Terraform outputs
cd ./infrastructure || exit
BUCKET_NAME="$(terraform output -raw bucket_name)"
PROFILE="$(terraform output -raw aws_profile)"
REGION="$(terraform output -raw aws_region)"

# Check if the bucket name was successfully retrieved
if [ -z "$BUCKET_NAME" ]; then
    echo "Error: Bucket name not found in Terraform output."
    exit 1
fi

# Check if the AWS profile was successfully retrieved
if [ -z "$PROFILE" ]; then
    echo "Error: AWS profile not found in Terraform output."
    exit 1
fi

# Check if the AWS region was successfully retrieved
if [ -z "$REGION" ]; then
    echo "Error: AWS region not found in Terraform output."
    exit 1
fi

# Upload files to the S3 bucket
cd .. || exit
aws s3api put-object --profile "$PROFILE" --bucket "$BUCKET_NAME" --key index.html --body "./app/index.html" --content-type "text/html"
aws s3api put-object --profile "$PROFILE" --bucket "$BUCKET_NAME" --key style.css --body "./app/style.css" --content-type "text/css"
aws s3api put-object --profile "$PROFILE" --bucket "$BUCKET_NAME" --key cat_image.png --body "./app/cat_image.png" --content-type "image/png"

echo "You have posted a static webpage with the following URL: "
echo "https://$BUCKET_NAME.s3.$REGION.amazonaws.com/index.html"
