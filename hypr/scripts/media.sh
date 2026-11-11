#!/usr/bin/env bash

set -euo pipefail

icon="$HOME/.config/swaync/icons/music.png"

notify() { notify-send -e -u low -i "$icon" "$@"; }

show_now_playing() {
  local status
  status=$(playerctl status)
  case "$status" in
    Playing)
      notify "Now Playing:" "$(playerctl metadata title) by $(playerctl metadata artist)" ;;
    Paused)
      notify "Playback:" "Paused" ;;
  esac
}

case "${1:-}" in
  --nxt)
    playerctl next
    show_now_playing ;;
  --prv)
    playerctl previous
    show_now_playing ;;
  --play)
    playerctl play-pause
    sleep 0.1 # status lags slightly right after play-pause
    show_now_playing ;;
  --stop)
    playerctl stop
    notify "Playback:" "Stopped" ;;
  *)
    echo "Usage: $0 [--nxt|--prv|--play|--stop]"
    exit 1 ;;
esac
