#!/bin/bash
set -eu

# commands to run after matugen generates templates. - Chris @2026-02-10 03:34 :)

JSON_OUTPUT_FILE="$HOME/.config/matugen/matugen-colors.json"

current_wallpaper=$($HOME/.config/hypr/scripts/get-current-swww-wallpaper.sh)
"$HOME/.config/hypr/scripts/make-static-wallpaper.sh" "$current_wallpaper"

echo "Outputting json to $JSON_OUTPUT_FILE"
matugen image "$current_wallpaper" --json hex --dry-run >"$JSON_OUTPUT_FILE"
echo "Created $JSON_OUTPUT_FILE successfully."
"$HOME/.config/hypr/scripts/colorize-wlogout-icons.sh"
echo "Finished."
