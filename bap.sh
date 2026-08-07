#!/bin/bash
set -euo pipefail

USERNAME="lohani01"
REPOSITORY="simple-mern-todo"

FRONTEND_IMAGE="$USERNAME/$REPOSITORY:frontend"
BACKEND_IMAGE="$USERNAME/$REPOSITORY:backend"

# Ensure buildx builder is ready
docker buildx create --use 2>/dev/null || true

# --- 1. Frontend Build & Push ---
echo "Building and pushing $FRONTEND_IMAGE for AMD64/ARM64..."
docker buildx build --platform linux/amd64,linux/arm64 -t "$FRONTEND_IMAGE" ./frontend --push

# --- 2. Backend Build & Push ---
echo "Building and pushing $BACKEND_IMAGE for AMD64/ARM64..."
docker buildx build --platform linux/amd64,linux/arm64 -t "$BACKEND_IMAGE" ./backend --push

echo "Done. Multi-arch images are live on Docker Hub."
