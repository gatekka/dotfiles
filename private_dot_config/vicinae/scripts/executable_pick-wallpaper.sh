#!/bin/bash
# @vicinae.schemaVersion 1
# @vicinae.title Pick Wallpaper
# @vicinae.mode compact
# @vicinae.exec ["/bin/bash"]

matugen image "$(find ~/.wallpapers -type f | vicinae dmenu -p 'Pick a wallpaper...')"
