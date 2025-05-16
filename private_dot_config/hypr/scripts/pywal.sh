main() {
  while true; do
    config_file="$HOME/.config/hyprwall/config.ini"

    # Wait for a valid file
    while true; do
      wallpaperPath="$HOME/$(grep -oP ".wallpapers/[^\"]+" "$config_file")"
      [ -f "$wallpaperPath" ] && break # Exit loop once file is valid
      sleep 0.5
    done

    wal -i "$wallpaperPath" -n
    bash "$HOME/.config/hypr/scripts/pywal_update_apps.sh" # Update pywal color scheme in external apps
    inotifywait -e modify "$config_file"
  done
}

main
