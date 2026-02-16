#!/bin/bash
# Return the current weather from https://wttr.in :) - Chris @ 02/16/2026

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

current_time=$(date "+%I:%M %p")
weather=$(curl -s 'wttr.in?format=%c%t\n%C\nTemperature:+%t\nHumidity:+%h\nWind:+%w\nPrecipitation:+%p\nDawn:+%D\nSunrise:+%S\nZenith:+%z\nSunset:+%s\nDusk:+%d')
weather_tooltip=$(printf "%s" "$weather" | awk '{printf "%s\\n", $0}')
text=$(echo "$weather" | head -n 1 | sed 's/  */ /g')
tooltip="$weather_tooltip\nLast Checked: $current_time"
output="{\"text\": \"$text\", \"tooltip\": \"$tooltip\"}"
echo "$output" >"$CACHE_FILE" # cache weather
echo "$output"
