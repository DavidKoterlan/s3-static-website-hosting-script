#!/bin/bash
set -u -e

read -p "Enter the name of the bucket you want to create: " BUCKET_NAME
read -p "Enter the region where you want to create the bucket: " BUCKET_LOCATION

mkdir config

PUBLIC_ACCESS_BLOCK_JSON='{
    "BlockPublicAcls": false,
    "IgnorePublicAcls": false,
    "BlockPublicPolicy": false,
    "RestrictPublicBuckets": false
}'

echo "$PUBLIC_ACCESS_BLOCK_JSON" > ./config/public-access-block.json

POLICY_JSON='{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowPublicReadAccess",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::'"$BUCKET_NAME"'/*"
        }
    ]
}'

echo "$POLICY_JSON" > ./config/bucket-policy.json

aws s3api create-bucket --bucket "$BUCKET_NAME" --create-bucket-configuration LocationConstraint="$BUCKET_LOCATION"
aws s3api put-public-access-block --bucket "$BUCKET_NAME" --public-access-block-configuration file://config/public-access-block.json
aws s3api put-bucket-policy --bucket "$BUCKET_NAME" --policy file://config/bucket-policy.json

aws s3api put-object --bucket "$BUCKET_NAME" --key index.html --body app/index.html --content-type "text/html"
aws s3api put-object --bucket "$BUCKET_NAME" --key style.css --body app/style.css --content-type "text/css"
aws s3api put-object --bucket "$BUCKET_NAME" --key cat_image.png --body app/cat_image.png --content-type "image/png"

echo "You have posted a static webpage with the following url: "
echo "https://$BUCKET_NAME.s3.$BUCKET_LOCATION.amazonaws.com/index.html"
