#!/usr/bin/env bash

set -euo pipefail

icon="$HOME/.config/swaync/icons/note.png"

if rfkill list wifi | grep -q "Soft blocked: yes"; then
  rfkill unblock wifi
  state="OFF"
else
  rfkill block wifi
  state="ON"
fi

notify-send -u low -i "$icon" "Airplane" "mode: $state"
