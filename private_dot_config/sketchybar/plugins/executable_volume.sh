#!/bin/sh

# The volume_change event supplies a $INFO variable in which the current volume
# percentage is passed to the script.

if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"

  case "$VOLUME" in
  100)
    ICON="􀊩  "
    ;;
  [6][7-9] | [7-9][0-9])
    ICON="􀊧  "
    ;;
  [3][4-9] | [4-5][0-9] | [6][0-6])
    ICON="􀊥 "
    ;;
  [1-9] | [1-2][0-9] | [3][0-3])
    ICON="􀊡 "
    ;;
  *) ICON="􀊣 " ;;
  esac

  sketchybar --set "$NAME" icon="$ICON" label="$VOLUME%"
fi
