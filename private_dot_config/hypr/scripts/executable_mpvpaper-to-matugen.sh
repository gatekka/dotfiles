#!/bin/bash

command -v mpvpaper >/dev/null 2>&1 || {
  echo "Error: mpvpaper is required but not installed." >&2
  exit 1
}
command -v matugen >/dev/null 2>&1 || {
  echo "Error: matugen is required but not installed." >&2
  exit 1
}

if [ $# -eq 0 ]; then
  echo "Usage: $0 <video_file>"
  echo "Example: $0 video.mp4"
  exit 1
fi

if [ ! -s "$1" ]; then
  echo "Invalid file."
  exit 1
fi

# kill any existing mpvpaper processes
echo "Stopping existing mpvpaper instances..."
pkill -x mpvpaper

echo "Starting new video wallpaper..."
mpvpaper -f -o "loop" ALL "$1"

$HOME/.config/matugen/scripts/video-to-matugen.sh "$1"

echo "Done!"
