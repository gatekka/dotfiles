# Whenever a user selects a new wallpaper with waypaper this script will copy the current wallpaper to "$HOME/.config/hyprwall/wallpaper.jpg" which hyprwall can reference.
# Requires waypaper

main() {
    while true; do
        config_file="$HOME/.config/waypaper/config.ini"

        # Wait for a valid file
        while true; do
            wallpaperPath="$HOME/$(sed -n 's/^wallpaper *= ~\/*//p' "$config_file")"
            [ -f "$wallpaperPath" ] && break # Exit loop once file is valid
            sleep 0.5
        done

        cp "$wallpaperPath" "$HOME/.config/hyprwall/wallpaper.jpg"
        inotifywait -e modify "$config_file"
    done
}

main
