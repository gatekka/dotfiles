#!/bin/bash

command -v swww >/dev/null 2>&1 || {
  echo "Error: swww is required but not installed." >&2
  exit 1
}

echo "Getting wallpaper..." >&2
wallpaper_path=$(swww query | awk -F'image: ' '{print $2; exit}')

if [[ -z "$wallpaper_path" ]]; then
  echo "Error: swww returned empty path" >&2
  exit 1
fi

if [[ ! -f "$wallpaper_path" ]]; then
  echo "Error: failed to get wallpaper path: $wallpaper_path" >&2
  exit 1
fi

echo "$wallpaper_path"
