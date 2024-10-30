declare -a plugin_paths
plugin_paths=(
  /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh # Installing with homebrew
  /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh # Installing with apt
  /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh # Installing with pacman
)

for file in $plugin_paths; do
  if [[ -f "$file" ]]; then
    source "$file"
    found=1
    break
  fi
done

(( ! found )) && echo "[oh-my-zsh] $plugin not found. Please install it first."

unset plugin_paths file found
