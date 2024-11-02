#!/bin/bash

startCava() {
  cavaProcessesAmount=$(pgrep -x cava | wc -l)
  if [ "$cavaProcessesAmount" -eq 0 ]; then
    cava -p ~/.config/cava/config1 | sed -u 's/;//g;s/0/▁/g;s/1/▂/g;s/2/▃/g;s/3/▄/g;s/4/▅/g;s/5/▆/g;s/6/▇/g;s/7/█/g;' &
  fi
}

stopCava() {
  pkill -9 cava && echo ""
  # cava_pid=$(pgrep -x cava)
  # if [ -n "$cava_pid" ]; then
  #   kill "$cava_pid"
  # fi
}

checkIfCorked() {
  # Check if any sink-input is corked
  if pactl list sink-inputs | grep -q 'Corked: no'; then
    startCava
  else
    stopCava
  fi
}

isSpotifyOpen() {
  # Check if Spotify is open
  if pgrep -x "spotify" >/dev/null; then
    startCava
  else
    stopCava
  fi
}

main() {
  pkill -9 cava 2>/dev/null # Kill any existing cava processes at the start
  while true; do
    while pactl list sink-inputs | grep -q 'Corked: no'; do
      startCava
      sleep 1
    done
    stopCava
    sleep 1
  done
}

main

# is_cava_ServerExist=$(ps -ef | grep -m 1 cava | grep -v "grep" | wc -l)
# if [ "$is_cava_ServerExist" = "0" ]; then
#   echo "cava_server not found" >/dev/null 2>&1
#   exit
# elif [ "$is_cava_ServerExist" = "1" ]; then
#   killall cava
# fi

# exec cava -p ~/.config/cava/config1 | sed -u 's/;//g;s/0/▁/g;s/1/▂/g;s/2/▃/g;s/3/▄/g;s/4/▅/g;s/5/▆/g;s/6/▇/g;s/7/█/g;'
