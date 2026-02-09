#!/bin/bash

set -e

command -v ffmpeg >/dev/null 2>&1 || {
  echo "Error: ffmpeg is required but not installed." >&2
  exit 1
}
command -v matugen >/dev/null 2>&1 || {
  echo "Error: matugen is required but not installed." >&2
  exit 1
}

# Check if video file argument is provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 <video_file>"
  echo "Example: $0 video.mp4"
  exit 1
fi

VIDEO_FILE="$1"

# Check if video file exists
if [ ! -f "$VIDEO_FILE" ]; then
  echo "Error: Video file '$VIDEO_FILE' not found."
  exit 1
fi

# Create temporary file for the first frame
TEMP_FRAME=$(mktemp --suffix=.png)
trap "rm -f $TEMP_FRAME" EXIT # clean up when script exits

echo "Extracting first frame from '$VIDEO_FILE'..."

# Extract first frame using ffmpeg
ffmpeg -i "$VIDEO_FILE" -vframes 1 -f image2 "$TEMP_FRAME" -y -loglevel error

if [ ! -s "$TEMP_FRAME" ]; then
  echo "Error: Failed to extract frame from video."
  exit 1
fi

echo "First frame extracted successfully."
echo "Generating color palette with matugen..."

matugen image "$TEMP_FRAME"

echo "Color palette generation complete!"
