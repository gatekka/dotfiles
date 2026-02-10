#!/usr/bin/env bash
TOP_BOTTOM_MARGIN_PERCENT=0.30

command -v wlogout >/dev/null 2>&1 || {
  echo "Error: wlogout is required but not installed." >&2
  notify-send -u critical "Error" "wlogout is required but not installed."
  exit 1
}

# check if wlogout is already running
if pgrep -x "wlogout" >/dev/null; then
  pkill -x "wlogout"
  exit 0
fi

# Detect monitor resolution and scaling factor
resolution=$(hyprctl -j monitors | jq -r '.[] | select(.focused==true) | .height / .scale' | awk -F'.' '{print $1}')
margin=$(awk "BEGIN {print int($resolution * $TOP_BOTTOM_MARGIN_PERCENT)}")
echo "$margin"
wlogout -b 5 -T "$margin" -B "$margin" &
