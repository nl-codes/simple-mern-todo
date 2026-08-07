#!/bin/bash
set -euo pipefail

# --- Settings ---
USERNAME="lohani01"
REPOSITORY="simple-mern-todo"
TAG="backend"
FULL_IMAGE="$USERNAME/$REPOSITORY:$TAG"
SERVICE_NAME="sm-backend"

# --- Connection Details ---
KEY="../secret/docker-mern-key.pem"
EC2_HOST="ec2-user@44.219.0.6"
REMOTE_APP_DIR="~/sm-mern"

echo "Deploying $FULL_IMAGE to $EC2_HOST ..."

ssh -o StrictHostKeyChecking=accept-new -i "$KEY" "$EC2_HOST" "
  cd $REMOTE_APP_DIR
  docker compose pull $SERVICE_NAME
  docker compose up -d --no-deps $SERVICE_NAME
"

echo "Backend deployment complete. API live on port 5050."
