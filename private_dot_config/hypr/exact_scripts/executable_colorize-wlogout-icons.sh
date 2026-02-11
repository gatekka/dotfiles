#!/bin/bash
set -eu

# colorizes all wlogout icons based off wallpaper colors with magick and outputs to same directory with _hover suffixed - Chris @2026-02-10 03:08 :)

ICONS="$HOME/.config/wlogout/icons"
OUTPUT_DIR="$HOME/.config/wlogout/icons-hover"
COLORS="$HOME/.config/matugen/matugen-colors.json"
COLOR=".colors.primary.default"

command -v magick >/dev/null 2>&1 || {
  echo "Error: magick is required but not installed." >&2
  exit 1
}

if [ ! -s "$COLORS" ]; then
  echo "Error: file is empty or doesn't exist. $COLORS" >&2
  exit 1
fi

echo "Colorizing wlogout icons: $ICONS"

color=$(jq -r "$COLOR" "$COLORS")
echo "Using color: $color"

for img in "$ICONS"/*.png; do
  # skip if glob didn't match any file
  [ -e "$img" ] || continue

  # extract filename and extension
  filename=$(basename "$img")
  ext="${filename##*.}"
  name="${filename%.*}"

  # output file with _hover suffix
  mkdir -p "$OUTPUT_DIR"
  out="$OUTPUT_DIR/${name}_hover.${ext}"

  # colorize with magick
  magick "$img" -fill "$color" -colorize 100% "$out" &

  echo "Created $out"
done

echo "Finished colorizing!"
