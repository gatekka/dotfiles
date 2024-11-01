checkIfCorked() {
  # Check if any sink-input is corked
  if pactl list sink-inputs | grep -q 'Corked: no'; then
    song_info=$(playerctl metadata artist --format "{{artist}} - {{title}}")
    echo "$song_info"
  fi
}

checkIfCorked
