#!/bin/sh
cd ./infrastructure || exit

# Extract bucket name and URL from Terraform outputs
BUCKET_NAME="$(terraform output -raw bucket_name)"
URL="$(terraform output -raw s3_bucket_url)"
PROFILE="$(terraform output -raw aws_profile)"

# Check if the bucket name was successfully retrieved
if [ -z "$BUCKET_NAME" ]; then
    echo "Error: Bucket name not found in Terraform output."
    exit 1
fi

# Check if the URL was successfully retrieved
if [ -z "$URL" ]; then
    echo "Error: S3 bucket URL not found in Terraform output."
    exit 1
fi

# Check if the AWS profile was successfully retrieved
if [ -z "$PROFILE" ]; then
    echo "Error: AWS profile not found in Terraform output."
    exit 1
fi

cd .. || exit
# Ensure paths are correct
aws s3api put-object --profile "$PROFILE" --bucket "$BUCKET_NAME" --key index.html --body "./app/index.html" --content-type "text/html"
aws s3api put-object --profile "$PROFILE" --bucket "$BUCKET_NAME" --key style.css --body "./app/style.css" --content-type "text/css"
aws s3api put-object --profile "$PROFILE" --bucket "$BUCKET_NAME" --key cat_image.png --body "./app/cat_image.png" --content-type "image/png"

echo "You have posted a static webpage with the following URL: "
echo "$URL"
