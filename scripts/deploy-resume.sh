#!/bin/bash
set -e

echo "Validate required environment variables"
if [ -z "$GITHUB_TOKEN" ] || [ -z "$DEST_USERNAME" ]; then
    echo "Error: Required environment variables not set"
    echo "Required: GITHUB_TOKEN, DEST_USERNAME"
    exit 1
fi

DEST_REPO_NAME=$(basename "$FILE_PATH")-resume

# Read visibility from config.json, default to public if not specified
CONFIG_FILE="$FILE_PATH/config.json"
VISIBILITY="public"
if [ -f "$CONFIG_FILE" ]; then
  VISIBILITY=$(jq -r '.visibility // "public"' "$CONFIG_FILE")
  echo "Repository visibility set to: $VISIBILITY"
fi

REPO_CREATED=false
if ! gh repo view "${DEST_USERNAME}/${DEST_REPO_NAME}" > /dev/null 2>&1; then
  echo "Repository ${DEST_USERNAME}/${DEST_REPO_NAME} not found. Creating it..."
  gh repo create "${DEST_USERNAME}/${DEST_REPO_NAME}" --"$VISIBILITY"
  REPO_CREATED=true
else
  echo "Repository exists. Checking if visibility needs to be updated..."
  CURRENT_VISIBILITY=$(gh repo view "${DEST_USERNAME}/${DEST_REPO_NAME}" --json visibility -q .visibility | tr '[:upper:]' '[:lower:]')
  if [ "$CURRENT_VISIBILITY" != "$VISIBILITY" ]; then
    echo "Updating repository visibility from $CURRENT_VISIBILITY to $VISIBILITY..."
    gh repo edit "${DEST_USERNAME}/${DEST_REPO_NAME}" --visibility "$VISIBILITY" --accept-visibility-change-consequences
    echo "Repository visibility updated."

    # If changing from private to public, we need to re-enable GitHub Pages
    if [ "$CURRENT_VISIBILITY" = "private" ] && [ "$VISIBILITY" = "public" ]; then
      echo "Re-enabling GitHub Pages after visibility change..."
      sleep 5
      gh api "repos/${DEST_USERNAME}/${DEST_REPO_NAME}/pages" \
        --method POST \
        -H "Accept: application/vnd.github+json" \
        -f source[branch]='main' \
        -f source[path]='/' 2>/dev/null || echo "GitHub Pages already enabled or will be enabled after push."
    fi

    # Give GitHub some time to process the visibility change
    echo "Waiting for GitHub to process visibility change..."
    sleep 5
  fi
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
