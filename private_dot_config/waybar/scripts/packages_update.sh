# Displays total number of out of date packages for pacman and yay.
# Requires yay AUR helper
# Chris @ 05/19/2025

main() {
    pacman_packages=$(checkupdates | wc -l)
    aur_packages=$(yay -Qua | wc -l)
    total_updates=$(( $pacman_packages + $aur_packages ))

    text="$total_updates"
    tooltip="Pacman: $pacman_packages updates\nAUR: $aur_packages updates"

    # Must return as json format https://man.archlinux.org/man/extra/waybar/waybar-custom.5.en#RETURN-TYPE
    echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\"}"
}

main
