#!/bin/bash

# Kill any existing cava processes at the start
killall cava 2>/dev/null

start_cava() {
  is_cava_ServerExist=$(pgrep -x cava | wc -l)
  if [ "$is_cava_ServerExist" -eq 0 ]; then
    #Starting cava
    cava -p ~/.config/cava/config1 | sed -u 's/;//g;s/0/▁/g;s/1/▂/g;s/2/▃/g;s/3/▄/g;s/4/▅/g;s/5/▆/g;s/6/▇/g;s/7/█/g;' &
  fi
}

# Kill cava if running
stop_cava() {
  killall cava
  echo ""
  # cava_pid=$(pgrep -x cava)
  # if [ -n "$cava_pid" ]; then
  #   kill "$cava_pid"
  # fi
}

checkIfCorked() {
  # Check if any sink-input is corked
  if pactl list sink-inputs | grep -q 'Corked: no'; then
    start_cava
  else
    stop_cava
  fi
}

isSpotifyOpen() {
  # Check if Spotify is running
  if pgrep -x "spotify" >/dev/null; then
    #Spotify is running
    start_cava
  else
    #Spotify is not running. Stopping cava if active"
    stop_cava
  fi
}

while true; do
  checkIfCorked
done

# is_cava_ServerExist=$(ps -ef | grep -m 1 cava | grep -v "grep" | wc -l)
# if [ "$is_cava_ServerExist" = "0" ]; then
#   echo "cava_server not found" >/dev/null 2>&1
# #	exit;
# elif [ "$is_cava_ServerExist" = "1" ]; then
#   killall cava
# fi

# exec cava -p ~/.config/cava/config1 | sed -u 's/;//g;s/0/▁/g;s/1/▂/g;s/2/▃/g;s/3/▄/g;s/4/▅/g;s/5/▆/g;s/6/▇/g;s/7/█/g;'
