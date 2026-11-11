#!/usr/bin/env bash

set -euo pipefail

theme="freedesktop"
default_theme="freedesktop"

usage() {
  echo "Usage: $0 [--screenshot|--volume|--notification|--startup|--logout]"
}

case "${1:-}" in
  --screenshot)   sound_option="screen-capture.*" ;;
  --volume)       sound_option="audio-volume-change.*" ;;
  --notification) sound_option="message.*" ;;
  --startup)      sound_option="service-login.*" ;;
  --logout)       sound_option="service-logout.*" ;;
  *) usage; exit 0 ;;
esac

if [[ -d /run/current-system/sw/share/sounds ]]; then
  system_dir=/run/current-system/sw/share/sounds
else
  system_dir=/usr/share/sounds
fi
user_dir="$HOME/.local/share/sounds"

sound_dir="$system_dir/$default_theme"
if [[ -d $user_dir/$theme ]]; then
  sound_dir="$user_dir/$theme"
fi

inherit_theme=$(grep -im 1 "inherits" "$sound_dir/index.theme" | cut -d= -f2 || true)
inherit_dir="$sound_dir/../$inherit_theme"

sound_file=""
for dir in "$sound_dir" "$inherit_dir" "$user_dir/$default_theme" "$system_dir/$default_theme"; do
  sound_file=$(find -L "$dir/stereo" -name "$sound_option" -print -quit 2>/dev/null || true)
  [[ -n $sound_file ]] && break
done

if [[ -z $sound_file ]]; then
  echo "Error: sound file not found." >&2
  exit 1
fi

for player in pw-play paplay aplay; do
  if command -v "$player" >/dev/null 2>&1; then
    "$player" "$sound_file" && exit 0
  fi
done

echo "Error: no suitable audio player (pw-play/paplay/aplay) found." >&2
exit 1
