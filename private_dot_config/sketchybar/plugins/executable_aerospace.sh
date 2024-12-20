#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" background.drawing=on background.color=0x44ffffff
else
  sketchybar --set "$NAME" background.drawing=off background.color=0x66494d64
fi
