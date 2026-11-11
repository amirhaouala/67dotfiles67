--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

-- Gradient border colors
hl.window_rule({
    name  = "floating-border-color",
    match = { float = true },

    border_color = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
})

hl.window_rule({
    name  = "fullscreen-border-color",
    match = { fullscreen = true },

    border_color = { colors = { "rgb(FFFF00)", "rgb(EE4B55)" }, angle = 45 },
})

--------------------------------
-- FLOAT / CENTER

-- Viewers: float, center, 60% x 90%
hl.window_rule({
    name   = "float-center-viewers",
    match  = { class = "^(org.pwmt.zathura|org.gnome.Loupe|org.gnome.SystemMonitor)$" },
    float  = true,
    center = true,
    size   = "(monitor_w*0.6) (monitor_h*0.9)",
})

-- Settings & utilities: float, center, 70% x 70%
hl.window_rule({
    name   = "float-center-settings-utils",
    match  = { class = "^([Bb]aobab|org.gnome.[Bb]aobab|gnome-disks|org.gnome.DiskUtility|nm-connection-editor|blueman-manager)$" },
    float  = true,
    center = true,
    size   = "(monitor_w*0.7) (monitor_h*0.7)",
})

-- Kitty
hl.window_rule({
    name  = "float-kitty",
    match = { class = "^kitty$" },
    float = true,
})

-- GNOME Settings app
hl.window_rule({
    name  = "float-gnome-settings",
    match = { class = "^org.gnome.Settings$" },
    float = true,
})

-- Nautilus: float + center (matches all windows; the `modal` match prop
-- does not work for Wayland-native dialogs in Hyprland 0.56.x, so dialogs
-- can't be matched on their own)
hl.window_rule({
    name   = "float-center-nautilus",
    match  = { class = "org.gnome.Nautilus" },
    float  = true,
    center = true,
})

-- File chooser dialogs from xdg-desktop-portal-gtk
hl.window_rule({
    name   = "float-center-portal-dialogs",
    match  = { class = "xdg-desktop-portal-gtk" },
    float  = true,
    center = true,
    size   = "(monitor_w*0.7) (monitor_h*0.6)",
})

-- VSCodium popups and dialogs
hl.window_rule({
    name  = "float-codium-popups",
    match = {
        class = "^(codium|codium-url-handler|VSCodium)$",
        title = "negative:(.*[Cc]odium.*|.*VSCodium.*)",
    },
    float = true,
})

-- mpv: float, 90% x 80%
hl.window_rule({
    name  = "float-mpv",
    match = { class = "^mpv$" },
    float = true,
    size  = "(monitor_w*0.9) (monitor_h*0.8)",
})

-- GNOME Calculator: float, center, 25% x 30%
hl.window_rule({
    name   = "float-center-gnome-calculator",
    match  = { class = "^org.gnome.Calculator$" },
    float  = true,
    center = true,
    size   = "(monitor_w*0.25) (monitor_h*0.3)",
})

-- GNOME Clocks / Weather: float, 40% x 50%
hl.window_rule({
    name  = "float-gnome-clocks",
    match = { class = "^org.gnome.clocks$" },
    float = true,
    size  = "(monitor_w*0.4) (monitor_h*0.5)",
})

hl.window_rule({
    name  = "float-gnome-weather",
    match = { class = "^org.gnome.Weather$" },
    float = true,
    size  = "(monitor_w*0.4) (monitor_h*0.5)",
})

-- GNOME Text Editor: float
hl.window_rule({
    name  = "float-gnome-text-editor",
    match = { class = "^org.gnome.TextEditor$" },
    float = true,
})

-- MarkText: float, center, 30% x 50%
hl.window_rule({
    name   = "float-center-marktext",
    match  = { class = "^[Mm]arktext$" },
    float  = true,
    center = true,
    size   = "(monitor_w*0.3) (monitor_h*0.5)",
})

-- Emacs: small scratch window in the lower-left
hl.window_rule({
    name = "float-emacs-scratch",
    match = { class = "^[Ee]macs$" },
    float = true,
    move  = "(monitor_w*0.02) (monitor_h*0.67)",
    size  = "(monitor_w*0.4) (monitor_h*0.3)",
})

-- Picture-in-Picture: float, top-right, keep aspect ratio
hl.window_rule({
    name = "float-picture-in-picture",
    match = { title = "^Picture-in-Picture$" },
    float = true,
    move  = "(monitor_w*0.72) (monitor_h*0.07)",
    keep_aspect_ratio = true,
})

-- Chrome/PWA windows (non-kimi): float, center, 70% x 70%
hl.window_rule({
    name   = "float-center-chrome",
    match  = { class = "^chrome.+", title = "negative:.*([Kk]imi|[Gg]emini).*" },
    float  = true,
    center = true,
    size   = "(monitor_w*0.7) (monitor_h*0.7)",
})

-- Kimi windows (PWA title contains "kimi"): small float at 60% / 10%
hl.window_rule({
    name  = "float-kimi",
    match = { class = "^chrome.+", title = ".*[Kk]imi.*" },
    float = true,
    move  = "(monitor_w*0.6) (monitor_h*0.1)",
    size  = "(monitor_w*0.35) (monitor_h*0.8)",
})

-- gemini windows (PWA title contains "gemini"): small float at 60% / 10%
hl.window_rule({
    name  = "float-gemini",
    match = { class = "^chrome.+", title = ".*[Gg]emini.*" },
    float = true,
    move  = "(monitor_w*0.6) (monitor_h*0.1)",
    size  = "(monitor_w*0.35) (monitor_h*0.8)",
})

-- kitty: float at 25% / 5%, 50% x 60%
hl.window_rule({
    name  = "float-kitty",
    match = { class = "^kitty$" },
    float = true,
    move  = "(monitor_w*0.25) (monitor_h*0.05)",
    size  = "(monitor_w*0.5) (monitor_h*0.6)",
})
