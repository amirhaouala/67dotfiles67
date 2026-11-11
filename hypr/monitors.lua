------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

-- Disable the laptop's built-in display
hl.monitor({
    output = "eDP-1",
})

-- Use the external HDMI display at its preferred resolution and refresh rate
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "highrr",
    position = "auto",
    scale    = "auto",
})

-- Verify connector names with: hyprctl monitors
