#!/bin/bash

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <owner/repo> <keyword> [token]"
  echo "  <owner/repo>: GitHub repository (e.g., torvalds/linux)"
  echo "  <keyword>: Keyword to search for in the file name"
  echo "  [token]: Optional GitHub token to bypass API rate limits"
  exit 1
fi

REPO="$1"
KEYWORD="$2"
TOKEN="${3:-}"
API_URL="https://api.github.com/repos/$REPO/releases/latest"
HEADER=""

if [[ -n "$TOKEN" ]]; then
  HEADER="-H Authorization: token $TOKEN"
fi

response=$(curl -s $HEADER "$API_URL")

if [[ $? -ne 0 || -z "$response" ]]; then
  echo "Failed to connect to GitHub API. Check your connection or token."
  exit 1
fi

asset_url=$(echo "$response" | grep -oP '"browser_download_url": "\K(https?://[^"]+)' | grep "$KEYWORD" | head -n 1)

if [[ -z "$asset_url" ]]; then
  echo "No file found containing the keyword '$KEYWORD'."
  exit 1
fi

echo "Downloading file from URL: $asset_url"
curl -L -O "$asset_url"

if [[ $? -ne 0 ]]; then
  echo "Failed to download the file. Check the URL or your network connection."
  exit 1
fi

echo "File downloaded successfully."
