# Requires matugen

main() {
  while true; do
    config_file="$HOME/.config/waypaper/config.ini"
    inotifywait -e modify "$config_file"

    # Wait for a valid file
    while true; do
      wallpaperPath="$HOME/$(sed -n 's/^wallpaper *= ~\/*//p' "$config_file")"
      [ -f "$wallpaperPath" ] && break # Exit loop once file is valid
      sleep 0.5
    done

    matugen image "$wallpaperPath"
  done
}

main
