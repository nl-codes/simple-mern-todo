#!/bin/bash
set -euo pipefail

USERNAME="lohani01"
REPOSITORY="simple-mern-todo"
BACKEND_IMAGE="$USERNAME/$REPOSITORY:backend"

# Ensure buildx builder is ready
docker buildx create --use 2>/dev/null || true

echo "Building and pushing $BACKEND_IMAGE for AMD64/ARM64..."
docker buildx build --platform linux/amd64,linux/arm64 -t "$BACKEND_IMAGE" ./backend --push

echo "Done. Backend multi-arch image is live on Docker Hub."
