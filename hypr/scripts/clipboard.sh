#!/usr/bin/env bash
# Clipboard history picker (cliphist + rofi).
#
# Keys:
#   Ctrl+Del  delete the selected entry
#   Alt+Del   wipe the entire history
#
# Note: no `set -e` here — rofi's exit codes are this script's control flow.

rofi_theme="$HOME/.config/rofi/config-clipboard.rasi"

# Close any rofi picker that is already open.
if pidof rofi >/dev/null 2>&1; then
  pkill rofi
fi

while true; do
  result=$(rofi -i -dmenu \
    -kb-custom-1 "Control-Delete" \
    -kb-custom-2 "Alt-Delete" \
    -config "$rofi_theme" < <(cliphist list))
  exit_code=$?

  case $exit_code in
    0)
      if [[ -n $result ]]; then
        cliphist decode <<<"$result" | wl-copy
        exit 0
      fi
      # Empty pick (Enter on nothing): reopen the picker.
      ;;
    1)
      exit 0 ;; # picker cancelled
    10)
      cliphist delete <<<"$result" ;;
    11)
      cliphist wipe ;;
  esac
done
