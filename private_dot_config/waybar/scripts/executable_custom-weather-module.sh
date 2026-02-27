#!/bin/bash
# Return the current weather from https://wttr.in :) - Chris @ 02/16/2026

LOCK_FILE="/tmp/waybar-custom-weather-module.lock"
CACHE_FILE="/tmp/waybar-custom-weather-module.cache"
LOG_FILE="/tmp/waybar-custom-weather-module.log"
CACHE_MAX_AGE=600 # in seconds

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] [PID: $$] $1" >>"$LOG_FILE"
}

log "Started process"

return_cached() {
  if [[ -f "$CACHE_FILE" ]]; then
    log "Returning cached data"
    cat "$CACHE_FILE"
    exit 0
  else
    # no cache available
    log "ERROR: No cache file available"
    echo "{\"text\": \"󰥖\", \"tooltip\": \"No cache file available :(\"}"
    exit 0
  fi
}

if [[ -f "$LOCK_FILE" ]]; then
  lock_pid=$(cat "$LOCK_FILE" 2>/dev/null)
  if [[ -n "$lock_pid" ]] && kill -0 "$lock_pid" 2>/dev/null; then
    log "Lock file exists, returning cached. (PID: $(cat $LOCK_FILE) is running)"
    return_cached
  else
    log "Removing stale lock file"
    rm -f "$LOCK_FILE"
  fi
fi

# if cache is not older than $CACHE_MAX_AGE, return cached
if [[ -f "$CACHE_FILE" ]]; then
  current_time=$(date +%s)                    # seconds in epoch
  cache_file_time=$(stat -c %Y "$CACHE_FILE") # seconds in epoch
  cache_age=$(($current_time - $cache_file_time))
  if [[ "$cache_age" -lt "$CACHE_MAX_AGE" ]]; then
    log "Cache is fresh (${cache_age}s old), returning cached"
    return_cached
    exit 0
  else
    log "Cache is old (${cache_age}s old), fetching new data"
  fi
fi

cleanup() {
  if [[ -f "$LOCK_FILE" ]]; then
    log "Cleaning up lock file..."
    rm -f "$LOCK_FILE"
  else
    log "No lock file to clean up."
  fi
}
trap cleanup EXIT INT TERM

log "Creating lock file..."
echo $$ >"$LOCK_FILE"

log "Fetching from wttr.in ..."
weather=$(curl -sf 'wttr.in?format=%t\n%C\nTemperature:+%t\nHumidity:+%h\nWind:+%w\nPrecipitation:+%p\nDawn:+%D\nSunrise:+%S\nZenith:+%z\nSunset:+%s\nDusk:+%d') || {
  log "ERROR: Failed to fetch primary weather data"
  return_cached
}
[[ -z "$weather" ]] && {
  log "ERROR: Empty response from wttr.in"
  return_cached
}

log "Fetching from v2d.wttr.in ..."
weather_2=$(curl -sf "v2d.wttr.in" | sed -n '39,42p') || {
  log "ERROR: Failed to fetch v2 weather data"
  return_cached
}
[[ -z "$weather_2" ]] && {
  log "ERROR: Empty response from v2d.wttr.in"
  return_cached
}

current_time=$(date "+%I:%M %p")
weather_icon=$(echo "$weather_2" | awk 'NR==1{print $2}') # get nerd-font icon from v2
weather_tooltip=$(printf "%s" "$weather" | awk '{printf "%s\\n", $0}')
text="$weather_icon $(echo "$weather" | head -n 1 | sed 's/  */ /g')"
tooltip="$weather_tooltip\nLast Checked: $current_time"
output="{\"text\": \"$text\", \"tooltip\": \"$tooltip\"}"
echo "$output" >"$CACHE_FILE" # cache weather
echo "$output"
log "Successfully fetched and cached weather data"
