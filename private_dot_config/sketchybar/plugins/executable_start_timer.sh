#!/bin/bash

# Define a state file to track whether the timer is running
STATE_FILE="/tmp/sketchybar_timer_state"
TIME_FILE="/tmp/sketchybar_timer_time"

# Function to display the elapsed time in HH:MM:SS format
display_time() {
  local total_seconds=$1
  local hours=$((total_seconds / 3600))
  local minutes=$(((total_seconds % 3600) / 60))
  local seconds=$((total_seconds % 60))
  sketchybar --set "$NAME" label="$(printf "%02d:%02d:%02d" "$hours" "$minutes" "$seconds")"
}

# Handle reset argument
if [[ $1 == "reset" ]]; then
  # Stop and reset the timer
  echo "stopped" >"$STATE_FILE"
  echo 0 >"$TIME_FILE"
  sketchybar --set "$NAME" label="00:00:00"
  exit 0
fi

# Toggle timer state
if [[ ! -f $STATE_FILE ]] || [[ $(cat $STATE_FILE) == "stopped" ]]; then
  # Start the timer
  echo "running" >"$STATE_FILE"

  # Initialize elapsed time
  if [[ ! -f $TIME_FILE ]]; then
    elapsed=0
  else
    elapsed=$(cat "$TIME_FILE")
  fi

  # Start counting up
  while [[ $(cat $STATE_FILE) == "running" ]]; do
    display_time "$elapsed"
    sleep 1
    elapsed=$((elapsed + 1))
    echo $elapsed >"$TIME_FILE"
  done
else
  # Stop the timer
  echo "stopped" >"$STATE_FILE"
  sketchybar --set "$NAME" label="Stopped"
fi
