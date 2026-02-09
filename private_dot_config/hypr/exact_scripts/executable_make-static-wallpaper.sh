#!/bin/bash

# Outputs a static image to $OUTPUT_DIR, converting from an mp4 or gif if needed. This is useful for referencing a wallpaper from anywhere like Hyprlock.
# @2026-02-08 23:50 - Chris

OUTPUT_DIR="$HOME/.cache"
OUTPUT_FILE="$OUTPUT_DIR/current_wallpaper.png"

command -v ffmpeg >/dev/null 2>&1 || {
  echo "Error: swww is required but not installed." >&2
  exit 1
}

if [ $# -eq 0 ]; then
  echo "Usage: $0 <file>"
  echo "Example: $0 <video.mp4>"
  exit 1
fi

if [[ ! -f "$1" ]]; then
  echo "Error: file not valid: $1" >&2
  exit 1
fi

# Check file extension
extension="${1##*.}"
extension_lower=$(echo "$extension" | tr '[:upper:]' '[:lower:]')

if [[ ! "$extension_lower" =~ ^(mp4|gif|png|jpg|jpeg)$ ]]; then
  echo "Error: unsupported file type: .$extension" >&2
  echo "Supported formats: mp4, gif, png, jpg, jpeg" >&2
  exit 1
fi

# Output location
mkdir -p "$OUTPUT_DIR"

# Extract frame or copy image
if [[ "$extension_lower" == "mp4" ]] || [[ "$extension_lower" == "gif" ]]; then
  # Extract first frame from video/gif
  ffmpeg -i "$1" -vframes 1 -q:v 2 "$OUTPUT_FILE" -y 2>/dev/null || {
    echo "Error: failed to extract frame from $1" >&2
    exit 1
  }
else
  # Copy static image (png/jpg/jpeg)
  cp "$1" "$OUTPUT_FILE" || {
    echo "Error: failed to copy image" >&2
    exit 1
  }
fi

echo "$OUTPUT_FILE"
