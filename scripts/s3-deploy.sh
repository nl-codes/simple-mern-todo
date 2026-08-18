#!/bin/bash
set -euo pipefail

# --- Settings ---
FRONTEND_DIR="frontend"
# S3_BUCKET="s3://simple-mern-todo-bucket" # passed from env

# Check if AWS session credentials are present
if [ -z "${AWS_SESSION_TOKEN:-}" ]; then
    echo "⚠️  Warning: AWS_SESSION_TOKEN is not set."
    echo "Make sure you copied the AWS CLI credentials from AWS Academy 'AWS Details'!"
fi

echo "0. Change directory to frontend"
cd "$FRONTEND_DIR"

echo "1. Building React static assets..."
npm run build

echo "2. Uploading dist/ folder to S3..."
# --delete ensures deleted local files are removed from the bucket
aws s3 sync ../frontend/dist/ "$S3_BUCKET" --delete

echo "----------------------------------------"
echo "Frontend deployment to S3 complete!"
echo "Website URL: http://simple-mern-todo-bucket.s3-website-us-east-1.amazonaws.com/"
echo "----------------------------------------"
