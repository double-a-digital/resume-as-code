#!/bin/bash
set -e

echo "Validate required environment variables"
if [ -z "$GITHUB_TOKEN" ] || [ -z "$DEST_USERNAME" ] || [ -z "$DEST_REPO_NAME" ]; then
    echo "Error: Required environment variables not set"
    echo "Required: GITHUB_TOKEN, DEST_USERNAME, DEST_REPO_NAME"
    exit 1
fi

echo "Deploying resume..."

echo "Configure git"
git config --global user.name "${GIT_USER_NAME:-github-actions[bot]}"
git config --global user.email "${GIT_USER_EMAIL:-github-actions[bot]@users.noreply.github.com}"

echo "Clone destination repository"
git clone "https://${GITHUB_TOKEN}@github.com/${DEST_USERNAME}/${DEST_REPO_NAME}.git" destination_repo

echo "Copy resume files"
cp index.html resume.html resume.pdf destination_repo/

echo "Deploy if there are changes"
cd destination_repo
if [ -n "$(git status --porcelain)" ]; then
    git add .
    git commit -m "$COMMIT_MESSAGE"
    git push origin main
    echo "Resume deployed successfully!"
else
    echo "No changes to deploy."
fi