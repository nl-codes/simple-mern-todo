#!/bin/bash
set -euo pipefail

USERNAME="lohani01"
REPOSITORY="simple-mern-todo"
FRONTEND_IMAGE="$USERNAME/$REPOSITORY:frontend"

# Ensure buildx builder is ready
docker buildx create --use 2>/dev/null || true

echo "Building and pushing $FRONTEND_IMAGE for AMD64/ARM64..."
docker buildx build --platform linux/amd64,linux/arm64 -t "$FRONTEND_IMAGE" ./frontend --push

echo "Done. Frontend multi-arch image is live on Docker Hub."
