#!/bin/bash
set -euo pipefail

# --- Settings ---
SERVICE_NAME="sm-mongo"

# --- Connection Details ---
KEY="../secret/docker-mern-key.pem"
EC2_HOST="ec2-user@44.219.0.6"
REMOTE_APP_DIR="~/sm-mern"

echo "Deploying $SERVICE_NAME to $EC2_HOST ..."

ssh -o StrictHostKeyChecking=accept-new -i "$KEY" "$EC2_HOST" "
  cd $REMOTE_APP_DIR
  docker compose pull $SERVICE_NAME
  docker compose up -d --no-deps $SERVICE_NAME
"

echo "MongoDB deployment complete. Service running on port 27017."
