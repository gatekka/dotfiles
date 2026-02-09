# Hyprpaper uses too much memory after selecting too many wallpapers with hyprwall. I can free memory by unloading unused wallpapers using the command: `hyprctl hyprpaper unload all`. (2024-11-08 16:52)
# This script fixes that issue

main() {
  while true; do
    config_file="$HOME/.config/hyprwall/config.ini"
    inotifywait -e modify "$config_file"
    sleep 2
    hyprctl hyprpaper unload all
  done
}

main
