-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 15,

        border_size = 2,

        col = {
            active_border   = { colors = {"rgba(00B77Dee)", "rgba(802400ee)"}, angle = 45 },
            inactive_border = "rgba(93745Faa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "master",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        -- Darken the screen behind a special workspace while it's open (0.0 - 1.0)
        dim_special = 0.8,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Curves from the old hyprlang config (UserAnimations.conf)
hl.curve("fluent_decel",  { type = "bezier", points = { {0, 0.2},  {0.4, 1}  } })
hl.curve("easeOutCirc",   { type = "bezier", points = { {0, 0.55}, {0.45, 1} } })
hl.curve("easeOutCubic",  { type = "bezier", points = { {0.33, 1}, {0.68, 1} } })
hl.curve("easeinoutsine", { type = "bezier", points = { {0.37, 0}, {0.63, 1} } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

-- Animations ported from the old hyprlang config
hl.animation({ leaf = "windows",       enabled = true,  speed = 1.5, bezier = "easeinoutsine" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 1.5, bezier = "easeinoutsine", style = "popin 60%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.5, bezier = "easeOutCubic",  style = "popin 60%" })
hl.animation({ leaf = "windowsMove",   enabled = true,  speed = 1.5, bezier = "easeinoutsine", style = "slide" })

hl.animation({ leaf = "fade",          enabled = true,  speed = 2.5, bezier = "fluent_decel" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 2.5, bezier = "fluent_decel" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 2.5, bezier = "fluent_decel" })

hl.animation({ leaf = "fadeLayersIn",  enabled = false })
hl.animation({ leaf = "border",        enabled = false })

hl.animation({ leaf = "layers",        enabled = true,  speed = 1.5, bezier = "easeinoutsine", style = "popin" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 1.5, bezier = "easeinoutsine", style = "popin" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5, bezier = "easeinoutsine", style = "popin" })

hl.animation({ leaf = "workspaces",    enabled = true,  speed = 3,   bezier = "fluent_decel", style = "slidefadevert 30%" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 3,   bezier = "fluent_decel", style = "slidefadevert 30%" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 3,   bezier = "fluent_decel", style = "slidefadevert 30%" })

hl.animation({ leaf = "specialWorkspace",    enabled = true, speed = 2, bezier = "fluent_decel", style = "slidefade 10%" })
hl.animation({ leaf = "specialWorkspaceIn",  enabled = true, speed = 2, bezier = "fluent_decel", style = "slidefade 10%" })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 2, bezier = "fluent_decel", style = "slidefade 10%" })

hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,   bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
})
