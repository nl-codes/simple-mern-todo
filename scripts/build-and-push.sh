scripts/build-and-push.sh
#!/bin/bash
set -euo pipefail
# settings arrive from the environment (the workflow provides them)
FULL_NAME="$DOCKERHUB_USERNAME/$IMAGE:$TAG"
# log in without a prompt, using the token piped in
echo "$DOCKERHUB_TOKEN" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin

# Ensure buildx builder is ready
docker buildx create --use 2>/dev/null || true
echo "Building $FULL_NAME from $CONTEXT ..."
docker buildx build --platform linux/amd64,linux/arm64 -t "$FULL_NAME" "$CONTEXT" --push

echo "Done. $FULL_NAME multi-arch image is live on Docker Hub."
