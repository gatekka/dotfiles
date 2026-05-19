#!/usr/bin/env bash

main() {
  awww-daemon # start wallpaper daemon
  matugen image "$wallpaperPath"
}

main "$@" # "$@" passes all positional parameters to script if needed
