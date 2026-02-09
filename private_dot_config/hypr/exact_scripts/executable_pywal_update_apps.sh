main() {
    reload-swaync-client
    reload-waybar
    reload-openrgb
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

reload-openrgb() {
    if pgrep -x "openrgb" >/dev/null; then
        pkill -x "openrgb"
    fi
    raw_color=$(sed -n '3p' ~/.cache/wal/colors-openrgb)
    saturated=$(saturate_color "$raw_color" 80)

    notify-send "Raw: $raw_color Saturated: $saturated"
    openrgb --startminimized --color "$saturated" -b 60 &
}

saturate_color() {
    local hex="$1"
    local percent="$2"

    # Prefix with # and format percent
    local input="#$hex"
    local factor
    factor=$(awk "BEGIN {printf \"%.2f\", 1 + $percent / 100}")

    # Create a 1x1 image, adjust saturation, output hex
    convert -size 1x1 xc:"$input" -modulate 100,"$(awk "BEGIN {print 100 * $factor}")",100 txt:- |
        grep -o '#[A-F0-9]\{6\}' | sed 's/#//'
}

main
