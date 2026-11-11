#!/bin/sh
# Applied to the running Hyprland session after wallust regenerates it.
# Uses `hyprctl eval` because the Lua config parser rejects `hyprctl keyword`.
# Active border: color10 averaged with color12 (wallust `blend`) -> color13,
# 45deg gradient, ee alpha (matches ~/.config/hypr/look_and_feel.lua).

hyprctl eval 'hl.config({ general = { col = { active_border = { colors = { "rgba({{color10 | saturate(1.0) | strip}}ee)", "rgba({{color13 | saturate(1.0) | strip}}ee)" }, angle = 45 } } } })' >/dev/null
hyprctl eval 'hl.config({ general = { col = { inactive_border = "rgba({{color10 | blend(color12) | strip}}aa)" } } })' >/dev/null
