#!/bin/bash
set -e

# Script to detect changed resume files (added, modified, or deleted)
# Outputs JSON arrays of resume paths for build and delete operations

EVENT_NAME="${1:-push}"
BEFORE_SHA="${2:-}"
AFTER_SHA="${3:-}"
MANUAL_FILE_PATH="${4:-}"

if [ "$EVENT_NAME" == "push" ]; then
  # Detect added/modified resumes (resume.json or config.json changes)
  ADDED_MODIFIED=$(git diff --name-only --diff-filter=AM "$BEFORE_SHA" "$AFTER_SHA" | grep -E 'resumes/.*/(resume|config)\.json' | xargs -I {} dirname {} | sort -u)
  if [ -z "$ADDED_MODIFIED" ]; then
    JSON_BUILD="[]"
  else
    JSON_BUILD=$(echo "$ADDED_MODIFIED" | jq -R . | jq -cs .)
  fi
  echo "build_resumes=$JSON_BUILD"

  # Detect deleted resumes
  DELETED=$(git diff --name-only --diff-filter=D "$BEFORE_SHA" "$AFTER_SHA" | grep 'resumes/.*/resume.json' | xargs -I {} dirname {} | sort -u)
  if [ -z "$DELETED" ]; then
    JSON_DELETE="[]"
  else
    JSON_DELETE=$(echo "$DELETED" | jq -R . | jq -cs .)
  fi
  echo "delete_resumes=$JSON_DELETE"
else
  # For manual trigger, only build is supported
  echo "build_resumes=[\"$MANUAL_FILE_PATH\"]"
  echo "delete_resumes=[]"
fi
