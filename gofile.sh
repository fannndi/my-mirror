#!/usr/bin/env bash
set -euo pipefail

ENDPOINT="https://upload.gofile.io/uploadfile"

FILE_PATH="$1"

response=$(curl -s -X POST "$ENDPOINT" -F "file=@${FILE_PATH}")

status=$(echo "$response" | jq -r '.status')

if [ "$status" != "ok" ]; then
  echo "Upload failed: $response"
  exit 1
fi

downloadPage=$(echo "$response" | jq -r '.data.downloadPage')

# output clean (tanpa text lain)
echo "$downloadPage"
