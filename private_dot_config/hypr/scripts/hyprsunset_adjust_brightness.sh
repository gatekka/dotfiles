#!/bin/bash

# Script to increase/decrease current temperature of hyprsunset. Made by Chris @11/25/2024 :)
# Requires hyprsunset to work
# Requires Dunstify to display notifications

TEMP_FILE="$HOME/.hyprsunset_temp"
CURRENT_TEMP=$(cat "$TEMP_FILE")
DEFAULT_TEMP=6500
MAX_TEMP=20000
MIN_TEMP=1000
INCREMENT=100
SHOW_NOTIFICATION=true
NOTIFY_ID=1
NOTIFY_FGCOLOR="#888888"
NOTIFY_BGCOLOR="#222222"

sendNotification() {
  if [[ "$SHOW_NOTIFICATION" = true ]]; then
    notify-send -h string:fgcolor:"$NOTIFY_FGCOLOR" -h string:bgcolor:"$NOTIFY_BGCOLOR" -r "$NOTIFY_ID" "hyprsunset" "$1"
  fi
}

increaseTemperature() {
  NEW_TEMP=$((CURRENT_TEMP + INCREMENT))
  if [[ $NEW_TEMP -gt $MAX_TEMP ]]; then
    sendNotification "Temperature max limit. Temperature has to be between $MIN_TEMP\K and $MAX_TEMP\K"
    return
  fi
  sendNotification "Set temperature to: $NEW_TEMP\K"
  echo "$NEW_TEMP" >"$TEMP_FILE"
  pkill -x "hyprsunset" # Kill any running hyprsunset processes
  hyprsunset --temperature "$NEW_TEMP"
}

decreaseTemperature() {
  NEW_TEMP=$((CURRENT_TEMP - INCREMENT))
  if [[ $NEW_TEMP -lt $MIN_TEMP ]]; then
    sendNotification "Temperature minimum limit. Temperature has to be between $MIN_TEMP\K and $MAX_TEMP\K"
    return
  fi
  sendNotification "Set temperature to: $NEW_TEMP\K"
  echo "$NEW_TEMP" >"$TEMP_FILE"
  pkill -x "hyprsunset" # Kill any running hyprsunset processes
  hyprsunset --temperature "$NEW_TEMP"
}

restoreTemperature() {
  sendNotification "Set temperature to: $CURRENT_TEMP\K"
  pkill -x "hyprsunset" # Kill any running hyprsunset processes
  hyprsunset --temperature "$CURRENT_TEMP"
}

main() {
  # Create file if file doesn't exist
  if [[ ! -f "$TEMP_FILE" ]]; then
    sendNotification "Creating file and setting temperature to 6500K..."
    echo "$DEFAULT_TEMP" >"$TEMP_FILE"
    exit 1
  fi

  # Optional arguments
  case "$2" in
  "--no-notify")
    SHOW_NOTIFICATION=false
    ;;
  *) ;;
  esac

  case "$1" in
  "increase")
    increaseTemperature
    ;;
  "decrease")
    decreaseTemperature
    ;;
  "restore")
    restoreTemperature
    ;;
  *)
    ;;
  esac
}

main "$1" "$2"
