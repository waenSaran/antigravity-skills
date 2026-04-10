#!/usr/bin/env bash

# submit-review.sh - Submits a batched PR review using GitHub CLI (gh api)
# Usage: ./submit-review.sh <PR_NUMBER> <JSON_PAYLOAD_FILE>

set -e

PR_NUMBER=$1
PAYLOAD_FILE=$2

if [ -z "$PR_NUMBER" ] || [ -z "$PAYLOAD_FILE" ]; then
  echo "Usage: $0 <PR_NUMBER> <JSON_PAYLOAD_FILE>"
  exit 1
fi

if [ ! -f "$PAYLOAD_FILE" ]; then
  echo "Error: Payload file '$PAYLOAD_FILE' not found."
  exit 1
fi

echo "Submitting review to PR #$PR_NUMBER..."

# Extract repo info
REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner)

# Submit review using gh api
gh api \
  --method POST \
  -H "Accept: application/vnd.github+json" \
  "/repos/$REPO/pulls/$PR_NUMBER/reviews" \
  --input "$PAYLOAD_FILE"

echo "✅ Review submitted successfully!"

# Cleanup temp JSON file
rm -f "$PAYLOAD_FILE"
echo "🗑️  Cleaned up temporary review file."
