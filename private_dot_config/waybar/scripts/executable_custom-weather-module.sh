#!/bin/bash
# Return the current weather from https://wttr.in :) - Chris @ 02/16/2026

LOCK_FILE="/tmp/waybar-custom-weather-module.lock"
CACHE_FILE="/tmp/waybar-custom-weather-module.cache"
CACHE_MAX_AGE=1800 # in seconds

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
  lock_pid=$(cat "$LOCK_FILE" 2>/dev/null)
  if [[ -n "$lock_pid" ]] && kill -0 "$lock_pid" 2>/dev/null; then
    return_cached
  else
    rm -f "$LOCK_FILE"
  fi
fi

# if cache is not older than $CACHE_MAX_AGE, return cached
if [[ -f "$CACHE_FILE" ]]; then
  current_time=$(date +%s)                    # seconds in epoch
  cache_file_time=$(stat -c %Y "$CACHE_FILE") # seconds in epoch
  cache_age=$(($current_time - $cache_file_time))
  if [[ "$cache_age" -lt "$CACHE_MAX_AGE" ]]; then
    return_cached
    exit 0
  fi
fi

cleanup() {
  rm -f "$LOCK_FILE"
}
trap cleanup EXIT INT TERM
echo $$ >"$LOCK_FILE"

current_time=$(date "+%I:%M %p")
weather=$(curl -s 'wttr.in?format=%t\n%C\nTemperature:+%t\nHumidity:+%h\nWind:+%w\nPrecipitation:+%p\nDawn:+%D\nSunrise:+%S\nZenith:+%z\nSunset:+%s\nDusk:+%d')
weather_2=$(curl -s "v2d.wttr.in" | sed -n '39,42p')      # data rich output format (v2)
weather_icon=$(echo "$weather_2" | awk 'NR==1{print $2}') # get nerd-font icon from v2
weather_tooltip=$(printf "%s" "$weather" | awk '{printf "%s\\n", $0}')
text="$weather_icon $(echo "$weather" | head -n 1 | sed 's/  */ /g')"
tooltip="$weather_tooltip\nLast Checked: $current_time"
output="{\"text\": \"$text\", \"tooltip\": \"$tooltip\"}"
echo "$output" >"$CACHE_FILE" # cache weather
echo "$output"
