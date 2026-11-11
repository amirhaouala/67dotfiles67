#!/usr/bin/env bash

set -euo pipefail

icons_dir="$HOME/.config/swaync/icons"
step=10
min_brightness=5

current_brightness() {
  brightnessctl -m | cut -d, -f4 | tr -d "%"
}

icon_for_brightness() {
  local level=$(( ($1 + 19) / 20 * 20 ))
  (( level > 100 )) && level=100
  echo "$icons_dir/brightness-${level}.png"
}

notify_brightness() {
  local brightness=$1
  notify-send -e -u low \
    -h string:x-canonical-private-synchronous:brightness_notif \
    -h int:value:"$brightness" \
    -i "$(icon_for_brightness "$brightness")" \
    "Screen" "Brightness: ${brightness}%"
}

change_brightness() {
  local delta=$1 current new
  current=$(current_brightness)
  new=$(( current + delta ))
  (( new < min_brightness )) && new=$min_brightness
  (( new > 100 )) && new=100
  brightnessctl set "${new}%" && notify_brightness "$new"
}

case "${1:-}" in
  --inc) change_brightness "$step" ;;
  --dec) change_brightness "-$step" ;;
  *) current_brightness ;;
esac
