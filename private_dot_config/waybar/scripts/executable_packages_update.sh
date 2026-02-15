# Displays total number of out of date packages for pacman and yay.
# Requires yay AUR helper
# Chris @ 05/19/2025

LOCK_FILE="/tmp/waybar-package-updates.lock"
CACHE_FILE="/tmp/waybar-package-updates.cache"

return_cached() {
  if [[ -f "$CACHE_FILE" ]]; then
    cat "$CACHE_FILE"
    exit 0
  else
    # no cache available
    echo "{\"text\": \"No cache file available\", \"tooltip\": \"No cache file available\"}"
    exit 0
  fi
}

if [[ -f "$LOCK_FILE" ]]; then
  # execute if $LOCK_FILE exists
  lock_pid=$(cat "$LOCK_FILE" 2>/dev/null)
  if [[ -n "$lock_pid" ]] && kill -0 "$lock_pid" 2>/dev/null; then
    # execute if $lock_pid is non-zero and actually exists as a running process
    return_cached
  else
    # remove stale $LOCK_FILE
    rm -f "$LOCK_FILE"
  fi
fi
echo $$ >"$LOCK_FILE" # create $LOCK_FILE with PID

cleanup() {
  rm -f "$LOCK_FILE"
}
trap cleanup EXIT INT TERM # ensure $LOCK_FILE is removed whenever process is killed/finished

main() {
  pacman_packages=$(checkupdates 2>/dev/null | wc -l)
  aur_packages=$(yay -Qua 2>/dev/null | wc -l)
  total_updates=$(($pacman_packages + $aur_packages))
  current_time=$(date "+%I:%M %p")
  text="$total_updates"
  tooltip="Pacman: $pacman_packages updates\nAUR: $aur_packages updates\nLast Checked: $current_time"

  # Must return as json format https://man.archlinux.org/man/extra/waybar/waybar-custom.5.en#RETURN-TYPE
  result="{\"text\": \"$text\", \"tooltip\": \"$tooltip\"}"
  echo "$result" >"$CACHE_FILE" # cache result
  echo "$result"
}

main
