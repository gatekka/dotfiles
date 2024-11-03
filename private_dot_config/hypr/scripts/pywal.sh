main() {
  # wal -R &
  # wal -i "$wallpaper" -n
  while true; do
    config_file="$HOME/.config/hyprwall/config.ini"
    wallpaper="$(grep -oP "$HOME/.wallpapers/[^\"]+" "$config_file")"
    wal -i "$wallpaper" -n --saturate 0.1 &
    inotifywait -e modify "$config_file"
    # sleep 1
  done
}

main
