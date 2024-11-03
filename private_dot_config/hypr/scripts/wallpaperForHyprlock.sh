# Whenever a user selects a new wallpaper with hyprwall this script will copy the current wallpaper to "$HOME/.config/hyprwall/wallpaper.jpg" which hyprwall can reference.
main() {
  while true; do
    config_file="$HOME/.config/hyprwall/config.ini"
    getWallpaperPath="$(grep -oP "$HOME/.wallpapers/[^\"]+" "$config_file")"
    cp "$getWallpaperPath" "$HOME/.config/hyprwall/wallpaper.jpg"
    inotifywait -e modify "$config_file"
    # echo "$getWallpaperPath"
  done
}

main
