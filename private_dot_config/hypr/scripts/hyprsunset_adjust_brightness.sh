#!/bin/bash

# Script to increase/decrease current temperature of hyprsunset. Made by Chris @11/25/2024 :)
# Requires hyprsunset to work
# Requires Dunstify to display notifications

TEMP_FILE="$HOME/.hyprsunset_temp"
CURRENT_TEMP=$(cat "$TEMP_FILE")
DEFAULT_TEMP=6500
MAX_TEMP=20000
MIN_TEMP=1000
INCREMENT=500
NOTIFY_ID=1
NOTIFY_FGCOLOR="#888888"
NOTIFY_BGCOLOR="#222222"

sendNotification() {
  notify-send -h string:fgcolor:"$NOTIFY_FGCOLOR" -h string:bgcolor:"$NOTIFY_BGCOLOR" -r "$NOTIFY_ID" "hyprsunset" "$1"
}

increaseTemperature() {
  NEW_TEMP=$((CURRENT_TEMP + INCREMENT))
  if [[ $NEW_TEMP -gt $MAX_TEMP ]]; then
    sendNotification "Temperature max limit. Temperature has to be between $MIN_TEMP\K and $MAX_TEMP\K"
    return
  fi
  sendNotification "Set temperature to: $NEW_TEMP\K"
  echo "$NEW_TEMP" >"$TEMP_FILE"
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
  hyprsunset --temperature "$NEW_TEMP"
}

main() {
  # Create file if file doesn't exist
  if [[ ! -f "$TEMP_FILE" ]]; then
    echo "$DEFAULT_TEMP" >"$TEMP_FILE"
  fi

  pkill -x "hyprsunset" # Kill any running hyprsunset processes

  case "$1" in
  "increase")
    increaseTemperature
    ;;
  "decrease")
    decreaseTemperature
    ;;
  *)
    hyprsunset --temperature "$DEFAULT_TEMP"
    ;;
  esac
}

main "$1"
