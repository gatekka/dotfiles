main() {
  reload-swaync-client
  reload-waybar
}

reload-swaync-client() {
  swaync-client -rs # Reload css file for swaync
}

reload-waybar() {
  if pgrep -x "waybar" >/dev/null; then
    pkill -x "waybar"
    sleep 1
  fi
  waybar &
}

main
