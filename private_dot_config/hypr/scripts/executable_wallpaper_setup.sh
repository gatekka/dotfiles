#!/usr/bin/env bash

create_matugen_templates() {
  while true; do
    config_file="$HOME/.config/waypaper/config.ini"
    inotifywait -e modify "$config_file"

    # Wait for a valid file
    while true; do
      wallpaperPath="$HOME/$(sed -n 's/^wallpaper *= ~\/*//p' "$config_file")"
      [ -f "$wallpaperPath" ] && break # Exit loop once file is valid
      sleep 1
    done

    matugen image "$wallpaperPath"
  done
}

main() {
  waypaper --restore         # restore wallpaper
  swww-daemon                # start wallpaper daemon
  create_matugen_templates & # generate matugen templates
}

main "$@" # "$@" passes all positional parameters to script if needed
