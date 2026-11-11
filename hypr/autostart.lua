-------------------
---- AUTOSTART ----
-------------------

local programs = require("programs")


-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function ()
  -- Kill leftovers from a previous (crashed) session before spawning new ones;
  -- duplicates fight over the wallpaper and destabilize the session.
  hl.exec_cmd("waybar & brave-origin & awww-daemon & hypridle &")
  hl.exec_cmd("$HOME/.config/hypr/scripts/slideshow.sh")
  hl.exec_cmd("wl-paste --type text --watch cliphist store &")
  hl.exec_cmd("wl-paste --type image --watch cliphist store &")
  hl.exec_cmd("hyprpolkitagent &")
end)
