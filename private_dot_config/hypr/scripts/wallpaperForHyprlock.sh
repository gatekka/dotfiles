# Whenever a user selects a new wallpaper with hyprwall this script will copy the current wallpaper to "$HOME/.config/hyprwall/wallpaper.jpg" which hyprwall can reference.
main() {
  while true; do
    config_file="$HOME/.config/hyprwall/config.ini"
    wallpaperPath="$HOME/$(grep -oP ".wallpapers/[^\"]+" "$config_file")"
    cp "$wallpaperPath" "$HOME/.config/hyprwall/wallpaper.jpg"
    inotifywait -e modify "$config_file"
  done
}

main
