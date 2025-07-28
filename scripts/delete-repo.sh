#!/bin/bash
set -e

echo "Validate required environment variables"
if [ -z "$GITHUB_TOKEN" ] || [ -z "$DEST_USERNAME" ] || [ -z "$DEST_REPO_NAME" ]; then
    echo "Error: Required environment variables not set"
    echo "Required: GITHUB_TOKEN, DEST_USERNAME, DEST_REPO_NAME"
    exit 1
fi

REPO_FULL_NAME="${DEST_USERNAME}/${DEST_REPO_NAME}"

echo "Checking if repository ${REPO_FULL_NAME} exists..."
if gh repo view "$REPO_FULL_NAME" > /dev/null 2>&1; then
  echo "Deleting repository ${REPO_FULL_NAME}..."
  gh repo delete "$REPO_FULL_NAME" --yes
  echo "Repository ${REPO_FULL_NAME} deleted successfully."
else
  echo "Repository ${REPO_FULL_NAME} does not exist. Nothing to delete."
fi
