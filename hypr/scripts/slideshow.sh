#!/usr/bin/env bash

set -euo pipefail

WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/Pictures/Wallpapers}"
INTERVAL="${INTERVAL:-150}"
MONITOR="${MONITOR:-}"

if [[ ! -d $WALLPAPER_DIR ]]; then
  echo "Error: directory '$WALLPAPER_DIR' not found." >&2
  echo "Set WALLPAPER_DIR to your wallpapers folder." >&2
  exit 1
fi

mapfile -t wallpapers < <(find "$WALLPAPER_DIR" -maxdepth 1 -type f \
  \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" \) | sort)

if (( ${#wallpapers[@]} == 0 )); then
  echo "Error: no images found in '$WALLPAPER_DIR'" >&2
  exit 1
fi

wallust_bin="$(command -v wallust || true)"
[[ -n $wallust_bin ]] || wallust_bin="$HOME/.cargo/bin/wallust"

if [[ -z $MONITOR ]]; then
  MONITOR=$(hyprctl monitors -j | jq -r ".[0].name" || true)
fi

echo "Found ${#wallpapers[@]} wallpapers. Interval: ${INTERVAL}s. Monitor: ${MONITOR:-unknown}"

cleanup() {
  echo "Cleaning up..."
  exit 0
}
trap cleanup SIGINT SIGTERM

index=0
while true; do
  wallpaper=${wallpapers[$index]}

  # A failure here shouldn't kill the slideshow.
  awww img -t wave -o "$MONITOR" "$wallpaper" 2>/dev/null || true

  # Regenerate the wallust palette and retheme Hyprland from this wallpaper.
  "$wallust_bin" run -s "$wallpaper" >/dev/null 2>&1 || true

  echo "[$(date +%H:%M:%S)] Set: $(basename "$wallpaper")"

  index=$(( (index + 1) % ${#wallpapers[@]} ))
  sleep "$INTERVAL"
done
