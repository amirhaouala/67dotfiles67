#!/usr/bin/env bash

set -euo pipefail

icons_dir="$HOME/.config/swaync/icons"
sounds_script="$HOME/.config/hypr/scripts/sounds.sh"
step=5

get_volume() { pamixer --get-volume; }
get_mic_volume() { pamixer --default-source --get-volume; }
is_muted() { [[ $(pamixer --get-mute) == true ]]; }
is_mic_muted() { [[ $(pamixer --default-source --get-mute) == true ]]; }

play_sound() {
  "$sounds_script" --volume &
}

icon_for_volume() {
  local level=$1
  if is_muted || (( level <= 0 )); then
    echo "$icons_dir/volume-mute.png"
  elif (( level <= 30 )); then
    echo "$icons_dir/volume-low.png"
  elif (( level <= 60 )); then
    echo "$icons_dir/volume-mid.png"
  else
    echo "$icons_dir/volume-high.png"
  fi
}

notify_volume() {
  local level
  level=$(get_volume)
  if is_muted || (( level == 0 )); then
    notify-send -e -u low \
      -h string:x-canonical-private-synchronous:volume_notif \
      -h boolean:SWAYNC_BYPASS_DND:true \
      -i "$(icon_for_volume "$level")" \
      "Volume:" "Muted"
  else
    notify-send -e -u low \
      -h int:value:"$level" \
      -h string:x-canonical-private-synchronous:volume_notif \
      -h boolean:SWAYNC_BYPASS_DND:true \
      -i "$(icon_for_volume "$level")" \
      "Volume Level:" "${level}%"
  fi
}

notify_mic() {
  local level
  level=$(get_mic_volume)
  if is_mic_muted || (( level == 0 )); then
    notify-send -e -u low \
      -h string:x-canonical-private-synchronous:volume_notif \
      -h boolean:SWAYNC_BYPASS_DND:true \
      -i "$icons_dir/microphone-mute.png" \
      "Mic Level:" "Muted"
  else
    notify-send -e -u low \
      -h int:value:"$level" \
      -h string:x-canonical-private-synchronous:volume_notif \
      -h boolean:SWAYNC_BYPASS_DND:true \
      -i "$icons_dir/microphone.png" \
      "Mic Level:" "${level}%"
  fi
}

inc_volume() {
  local amount=${1:-$step}
  if is_muted; then
    toggle_mute
  else
    pamixer -i "$amount" --allow-boost --set-limit 150 && notify_volume && play_sound
  fi
}

dec_volume() {
  local amount=${1:-$step}
  if is_muted; then
    toggle_mute
  else
    pamixer -d "$amount" && notify_volume && play_sound
  fi
}

toggle_mute() {
  if ! is_muted; then
    pamixer -m
    notify-send -e -u low -h boolean:SWAYNC_BYPASS_DND:true \
      -i "$icons_dir/volume-mute.png" "Mute"
  else
    pamixer -u
    notify-send -e -u low -h boolean:SWAYNC_BYPASS_DND:true \
      -i "$(icon_for_volume "$(get_volume)")" "Volume:" "Switched ON"
  fi
}

toggle_mic() {
  if ! is_mic_muted; then
    pamixer --default-source -m
    notify-send -e -u low -h boolean:SWAYNC_BYPASS_DND:true \
      -i "$icons_dir/microphone-mute.png" "Microphone:" "Switched OFF"
  else
    pamixer --default-source -u
    notify-send -e -u low -h boolean:SWAYNC_BYPASS_DND:true \
      -i "$icons_dir/microphone.png" "Microphone:" "Switched ON"
  fi
}

inc_mic_volume() {
  local amount=${1:-5}
  if is_mic_muted; then
    toggle_mic
  else
    pamixer --default-source -i "$amount" && notify_mic && play_sound
  fi
}

dec_mic_volume() {
  local amount=${1:-5}
  if is_mic_muted; then
    toggle_mic
  else
    pamixer --default-source -d "$amount" && notify_mic && play_sound
  fi
}

case "${1:-}" in
  --inc) inc_volume ;;
  --dec) dec_volume ;;
  --toggle) toggle_mute ;;
  --toggle-mic) toggle_mic ;;
  --mic-inc) inc_mic_volume ;;
  --mic-dec) dec_mic_volume ;;
  --get-icon) icon_for_volume "$(get_volume)" ;;
  *)
    echo "Usage: $0 [--inc|--dec|--toggle|--toggle-mic|--mic-inc|--mic-dec|--get-icon]"
    exit 1 ;;
esac
