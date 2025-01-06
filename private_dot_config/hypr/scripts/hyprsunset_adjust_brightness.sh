#!/bin/bash

# Script to increase/decrease current temperature of hyprsunset. Made by Chris @11/25/2024 :)
# Requires hyprsunset to work
# Requires Dunstify to display notifications
# Requires inotify-tools

TEMP_FILE="$HOME/.hyprsunset_temp"
DEFAULT_TEMP=6500
MAX_TEMP=20000
MIN_TEMP=1000
INCREMENT=100
SHOW_NOTIFICATION=true
NOTIFY_ID=1
NOTIFY_FGCOLOR="#888888"
NOTIFY_BGCOLOR="#222222"

sendNotification() {
  echo "$1"
  if [[ "$SHOW_NOTIFICATION" = true ]]; then
    notify-send -h string:fgcolor:"$NOTIFY_FGCOLOR" -h string:bgcolor:"$NOTIFY_BGCOLOR" -r "$NOTIFY_ID" "hyprsunset" "$1"
  fi
}

getCurrentTemperature() {
  if [[ ! -f "$TEMP_FILE" || "$(cat "$TEMP_FILE")" == "Off" ]]; then
    echo "$DEFAULT_TEMP"
  else
    cat "$TEMP_FILE"
  fi
}

increaseTemperature() {
  CURRENT_TEMP=$(getCurrentTemperature)
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
  CURRENT_TEMP=$(getCurrentTemperature)
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
  CURRENT_TEMP=$(getCurrentTemperature)
  sendNotification "Set temperature to: $CURRENT_TEMP\K"
  pkill -x "hyprsunset" # Kill any running hyprsunset processes
  hyprsunset --temperature "$CURRENT_TEMP"
}

turnOffTemperature() {
  pkill -x "hyprsunset" # Kill any running hyprsunset processes
  echo "Off" >"$TEMP_FILE"
  sendNotification "Turned off Hyprsunset"
}

watchTemperature() {
  while true; do
    CURRENT_TEMP=$(getCurrentTemperature)
    if grep -q "Off" "$TEMP_FILE"; then
      echo "Off"
    else
      echo "${CURRENT_TEMP}K"
    fi
    inotifywait -qq -e modify "$TEMP_FILE"
  done
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
  "off")
    turnOffTemperature
    ;;
  "waybar")
    watchTemperature
    ;;
  *)
    sendNotification "Commands: increase decrease restore off waybar"
    ;;
  esac
}

main "$1" "$2"
