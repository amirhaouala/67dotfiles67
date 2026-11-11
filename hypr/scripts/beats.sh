#!/usr/bin/env bash

set -euo pipefail

music_dir="$HOME/Music"
icons_dir="$HOME/.config/swaync/icons"
icon="$icons_dir/music.png"
rofi_theme="$HOME/.config/rofi/config-rofi-Beats.rasi"
rofi_theme_menu="$HOME/.config/rofi/config-rofi-Beats-menu.rasi"
music_list="$HOME/.config/rofi/online_music.list"

notify() { notify-send -u normal -i "$icon" "$@"; }

notify_err() { notify-send -u low -i "$icon" "$@"; }

mpv_running() { pgrep -x mpv >/dev/null; }

stop_music() {
  local pids excluded pid
  pids=$(pgrep -x mpv) || return
  # mpvpaper also runs an mpv process; don't kill that one.
  excluded=$(pgrep -f unique-wallpaper-process || true)

  for pid in $pids; do
    grep -qw "$pid" <<<"$excluded" || kill -9 "$pid" || true
  done
  notify "Music stopped"
}

play_online() {
  if [[ ! -s $music_list ]]; then
    notify_err "No online music found" "Add some with Manage Music"
    return
  fi

  local choice link
  choice=$(awk -F'|' '{print $1}' "$music_list" | sort | rofi -i -dmenu -config "$rofi_theme" \
    -theme-str 'entry { placeholder: "🌐 Choose Online Station"; }')
  [[ -n $choice ]] || exit 1

  link=$(awk -F'|' -v name="$choice" '$1 == name { print $2; exit }' "$music_list")
  if [[ -z $link ]]; then
    notify_err "URL not found for" "$choice"
    exit 1
  fi

  mpv_running && stop_music
  notify "Now Playing:" "$choice"
  mpv --no-video --shuffle "$link"
}

local_files=()
local_names=()

load_local_music() {
  local file
  while IFS= read -r file; do
    local_files+=("$file")
    local_names+=("$(basename "$file")")
  done < <(find -L "$music_dir" -type f \( -iname "*.mp3" -o -iname "*.flac" -o -iname "*.wav" \
    -o -iname "*.ogg" -o -iname "*.mp4" -o -iname "*.webm" \))
}

play_local() {
  load_local_music

  local choice i
  choice=$(printf "%s\n" "${local_names[@]}" | rofi -i -dmenu -config "$rofi_theme" \
    -theme-str 'entry { placeholder: "🎵 Choose Local Music"; }')
  [[ -n $choice ]] || exit 1

  for i in "${!local_names[@]}"; do
    if [[ ${local_names[$i]} == "$choice" ]]; then
      mpv_running && stop_music
      notify "Now Playing:" "$choice"
      mpv --no-video --playlist-start="$i" --loop-playlist "${local_files[@]}"
      return
    fi
  done

  notify_err "Not found in music directory:" "$choice"
}

shuffle_local() {
  mpv_running && stop_music
  notify "Shuffle Play local music"
  mpv --no-video --shuffle --loop-playlist "$music_dir"
}

choice=$(printf "%s\n" \
  "Play from Online Stations" \
  "Play from Music directory" \
  "Shuffle Play from Music directory" \
  "Stop RofiBeats" |
  rofi -dmenu -config "$rofi_theme_menu" \
    -theme-str 'entry { placeholder: "🎧 RofiBeats Menu"; }')

case "$choice" in
  "Play from Online Stations") play_online ;;
  "Play from Music directory") play_local ;;
  "Shuffle Play from Music directory") shuffle_local ;;
  "Stop RofiBeats") mpv_running && stop_music ;;
esac
