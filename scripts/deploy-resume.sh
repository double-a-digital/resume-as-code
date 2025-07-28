#!/bin/bash
set -e

echo "Validate required environment variables"
if [ -z "$GITHUB_TOKEN" ] || [ -z "$DEST_USERNAME" ] || [ -z "$DEST_REPO_NAME" ]; then
    echo "Error: Required environment variables not set"
    echo "Required: GITHUB_TOKEN, DEST_USERNAME, DEST_REPO_NAME"
    exit 1
fi

echo "Authenticate with GitHub CLI"
gh auth login --with-token <<< "$GITHUB_TOKEN"

REPO_CREATED=false
if ! gh repo view "${DEST_USERNAME}/${DEST_REPO_NAME}" > /dev/null 2>&1; then
  echo "Repository ${DEST_USERNAME}/${DEST_REPO_NAME} not found. Creating it..."
  gh repo create "${DEST_USERNAME}/${DEST_REPO_NAME}" --public
  REPO_CREATED=true
fi

echo "Deploying resume..."

echo "Configure git"
git config --global user.name "${GIT_USER_NAME:-github-actions[bot]}"
git config --global user.email "${GIT_USER_EMAIL:-github-actions[bot]@users.noreply.github.com}"

echo "Clone destination repository"
git clone "https://${GITHUB_TOKEN}@github.com/${DEST_USERNAME}/${DEST_REPO_NAME}.git" destination_repo

echo "Copy resume files"
cp $FILE_PATH/index.html $FILE_PATH/resume.html $FILE_PATH/resume.pdf destination_repo/

echo "Deploy if there are changes"
cd destination_repo
if [ -n "$(git status --porcelain)" ]; then
    git add .
    git commit -m "$COMMIT_MESSAGE"
    git push origin main
    echo "Resume deployed successfully!"

    if [ "$REPO_CREATED" = true ]; then
      echo "Enabling GitHub Pages for the new repository..."
      # It can take a few seconds for the main branch to be recognized after push
      sleep 5
      gh api "repos/${DEST_USERNAME}/${DEST_REPO_NAME}/pages" \
        --method POST \
        -H "Accept: application/vnd.github+json" \
        -f source[branch]='main' \
        -f source[path]='/'
      echo "GitHub Pages enabled."
    fi
else
    echo "No changes to deploy."
fi
