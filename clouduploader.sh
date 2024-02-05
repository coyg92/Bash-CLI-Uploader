#!/bin/bash

# Define AWS S3 bucket name and region
S3_BUCKET="clouduploader-bucket"
AWS_REGION="us-east-1"

# Check if AWS CLI is installed
command -v aws >/dev/null 2>&1 || { echo >&2 "AWS CLI is required but not installed. Aborting."; exit 1; }

# Check if AWS CLI is configured
aws configure get aws_access_key_id || { echo >&2 "AWS CLI is not configured. Run 'aws configure' to set up your credentials. Aborting."; exit 1; }

# Check if at least one argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <file-to-upload>"
    exit 1
fi

# Get the file to upload
FILE_TO_UPLOAD=$1

# Check if the file exists
if [ ! -f "$FILE_TO_UPLOAD" ]; then
    echo "Error: File not found: $FILE_TO_UPLOAD"
    exit 1
fi

# Extract file name from path
FILE_NAME=$(basename "$FILE_TO_UPLOAD")

# Upload the file to S3
echo "Uploading $FILE_NAME to $S3_BUCKET..."
aws s3 cp "$FILE_TO_UPLOAD" "s3://$S3_BUCKET/"

echo "Upload completed."
