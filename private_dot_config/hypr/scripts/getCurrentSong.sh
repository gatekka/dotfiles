song_info=$(playerctl metadata artist --format "{{artist}} - {{title}}")
echo "$song_info"
