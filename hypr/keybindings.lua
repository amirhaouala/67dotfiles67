---------------------
---- KEYBINDINGS ----
---------------------

local programs = require("programs")

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close()) -- Close active window
local killWindowBind = hl.bind(mainMod .. " + B", hl.dsp.window.kill()) -- Kill active window's process
hl.bind(mainMod .. " + S", hl.dsp.window.float({ action = "toggle" })) -- Toggle floating for active window
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen_state({ internal = 0, client = 2 })) -- Toggle fake fullscreen (app thinks it's fullscreen, window stays tiled)
hl.bind(mainMod .. " + CTRL + F", hl.dsp.window.fullscreen({ action = "toggle" })) -- Toggle fullscreen for active window
hl.bind(mainMod .. " + grave", hl.dsp.window.fullscreen({ mode = "maximized" })) -- Toggle maximize (fake fullscreen, window fills working area but keeps margins)
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- Toggle pseudo-tiling for active window
hl.bind(mainMod .. " + O", hl.dsp.layout("togglesplit"))    -- Toggle split direction (dwindle only)
hl.bind(mainMod .. " + Space", hl.dsp.layout("swapwithmaster")) -- Swap active window with master

-- Utilities
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("hyprpicker -a -n")) -- Pick a color on screen and copy its hex value

-- Commands
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("killall wlogout || wlogout")) -- Open logout menu
hl.bind(mainMod .. " + Delete", hl.dsp.exec_cmd("hyprlock")) -- Lock screen with hyprlock
hl.bind(mainMod .. " + SHIFT + Delete", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")) -- Shutdown or exit Hyprland
hl.bind(mainMod .. " + ALT + Delete",  hl.dsp.exec_cmd("reboot")) -- Reboot the system
hl.bind(mainMod .. " + CTRL + Delete", hl.dsp.exec_cmd("shutdown now")) -- Shut down the system immediately
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(programs.menu)) -- Open application menu
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(programs.fileManager)) -- Open file manager
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("ptyxis --new-window")) -- Open terminal
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("emacsclient -c -a emacs")) -- Open Emacs client
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("killall waybar ; waybar &")) -- Restart waybar
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("swaync-client -t -sw")) -- Toggle notification center (swaync)
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("pkill rofi || $HOME/.config/hypr/scripts/clipboard.sh"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("pkill rofi || $HOME/.config/hypr/scripts/emojis.sh"))
hl.bind(mainMod .. " + U", hl.dsp.exec_cmd("pkill rofi || $HOME/.config/hypr/scripts/beats.sh"))
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.exec_cmd("XDG_CURRENT_DESKTOP='GNOME:Hyprland' gnome-control-center")) -- Open GNOME Settings
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd("xdg-open 'https://'")) -- Open Default Browser
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("codium")) -- Open VSCodium
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("gnome-boxes")) -- Open GNOME Boxes (virtual machines)
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("ptyxis -- asciiquarium")) -- Open asciiquarium in a terminal
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("ptyxis -- ~/go/bin/lazydocker")) -- Open lazydocker in a terminal
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("ptyxis -- ~/go/bin/gotop")) -- Open gotop in a terminal
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exec_cmd("/usr/bin/distrobox-enter  -n deb  --   webapp-manager")) -- Open WebApp Manager
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd("obs")) -- Open OBS Studio
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("gnome-text-editor")) -- Open Gnome Text Editor

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true }) -- Drag window with left mouse button + mainMod
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- Resize window with right mouse button + mainMod

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + W",         hl.dsp.workspace.toggle_special("magic"))        -- Toggle special scratchpad workspace
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.window.move({ workspace = "special:magic" })) -- Move active window to scratchpad workspace

-- Screenshots
hl.env("HYPRSHOT_DIR", os.getenv("HOME") .. "/Pictures/Screenshots") -- Save screenshots to ~/Pictures/Screenshots
hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m region")) -- Screenshot a region
hl.bind("CTRL + Print", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only")) -- Screenshot a region to the clipboard only
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m output")) -- Screenshot the whole screen
hl.bind("SUPER + Print", hl.dsp.exec_cmd("hyprshot -m window")) -- Screenshot the active window
hl.bind("ALT + Print", hl.dsp.exec_cmd("hyprshot -zm region")) -- Screenshot a region with a frozen screen

-- Chromium profiles
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd('chromium-browser --profile-directory="Profile 1"')) -- Open Chromium (Profile 1)
hl.bind(mainMod .. " + F2", hl.dsp.exec_cmd('chromium-browser --profile-directory="Profile 2"')) -- Open Chromium (Profile 2)
hl.bind(mainMod .. " + F3", hl.dsp.exec_cmd('chromium-browser --profile-directory="Profile 3"')) -- Open Chromium (Profile 3)
hl.bind(mainMod .. " + F4", hl.dsp.exec_cmd('chromium-browser --profile-directory="Profile 4"')) -- Open Chromium (Profile 4)
hl.bind(mainMod .. " + F5", hl.dsp.exec_cmd('chromium-browser --profile-directory="Profile 5"')) -- Open Chromium (Profile 5)
hl.bind(mainMod .. " + F6", hl.dsp.exec_cmd('chromium-browser --profile-directory="Profile 6"')) -- Open Chromium (Profile 6)
hl.bind(mainMod .. " + F7", hl.dsp.exec_cmd('chromium-browser --profile-directory="Profile 7"')) -- Open Chromium (Profile 7)
hl.bind(mainMod .. " + F8", hl.dsp.exec_cmd('chromium-browser --profile-directory="Profile 8"')) -- Open Chromium (Profile 8)
hl.bind(mainMod .. " + F9", hl.dsp.exec_cmd('chromium-browser --profile-directory="Profile 9"')) -- Open Chromium (Profile 9)
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd('chromium-browser --profile-directory="Profile 10"')) -- Open Chromium (Profile 10)

hl.bind(mainMod .. " + SHIFT + Backspace", hl.dsp.exec_cmd(
    'chromium --app="https://kimi.ai/" --class=WebApp-Kimi6099 --name=WebApp-Kimi6099 --user-data-dir=/home/humbleman/.local/share/ice/profiles/Kimi6099'
))
hl.bind(mainMod .. " + SHIFT + Backspace", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + SHIFT + Backspace", hl.dsp.exec_cmd("emacsclient -c -a 'emacs'"))

hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd(
    'chromium --app="https://gemini.google.com/" --class=WebApp-Gemini5403 --name=WebApp-Gemini5403'
))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd("emacsclient -c -a 'emacs'"))

hl.bind("ALT + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next({ next = false }))
    hl.dispatch(hl.dsp.window.bring_to_top())
end) -- Cycle through windows (classic Alt+Tab behavior)

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/volume.sh --toggle"),     { locked = true, repeating = true }) -- Toggle audio mute
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/volume.sh --toggle-mic"),   { locked = true, repeating = true }) -- Toggle microphone mute
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/volume.sh --inc"), { locked = true, repeating = true }) -- Raise volume
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/volume.sh --dec"),      { locked = true, repeating = true }) -- Lower volume
hl.bind("ALT + UP", 		hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/volume.sh --inc"), { locked = true, repeating = true }) -- Raise volume
hl.bind("ALT + DOWN", 		hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/volume.sh --dec"),      { locked = true, repeating = true }) -- Lower volume
hl.bind("ALT + Page_Up", 		hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/volume.sh --inc"), { locked = true, repeating = true }) -- Raise volume
hl.bind("ALT + Page_Down", 		hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/volume.sh --dec"),      { locked = true, repeating = true }) -- Lower volume
hl.bind("ALT + K", 		hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/volume.sh --inc"), { locked = true, repeating = true }) -- Raise volume
hl.bind("ALT + J", 		hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/volume.sh --dec"),      { locked = true, repeating = true }) -- Lower volume
hl.bind("ALT + SHIFT + UP", 		hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/volume.sh --mic-inc"), { locked = true, repeating = true }) -- Raise volume
hl.bind("ALT + SHIFT + DOWN", 		hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/volume.sh --mic-dec"),      { locked = true, repeating = true }) -- Lower volume
hl.bind("ALT + SHIFT + Page_Up", 		hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/volume.sh --mic-inc"), { locked = true, repeating = true }) -- Raise volume
hl.bind("ALT + SHIFT + Page_Down", 		hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/volume.sh --mic-dec"),      { locked = true, repeating = true }) -- Lower volume
hl.bind("ALT + SHIFT + K", 		hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/volume.sh --mic-inc"), { locked = true, repeating = true }) -- Raise volume
hl.bind("ALT + SHIFT + J", 		hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/volume.sh --mic-dec"),      { locked = true, repeating = true }) -- Lower volume
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/brightness.sh --inc"),                  { locked = true, repeating = true }) -- Increase screen brightness
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/brightness.sh --dec"),                  { locked = true, repeating = true }) -- Decrease screen brightness
hl.bind("ALT + SHIFT + RIGHT",  hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/brightness.sh --inc"),                  { locked = true, repeating = true }) -- Increase screen brightness
hl.bind("ALT + SHIFT + LEFT",hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/brightness.sh --dec"),                  { locked = true, repeating = true }) -- Decrease screen brightness
hl.bind("ALT + SHIFT + L",  hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/brightness.sh --inc"),                  { locked = true, repeating = true }) -- Increase screen brightness
hl.bind("ALT + SHIFT + H",hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/brightness.sh --dec"),                  { locked = true, repeating = true }) -- Decrease screen brightness

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/media.sh --nxt"),       { locked = true }) -- Next track
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/media.sh --prv"),   { locked = true }) -- Previous track
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/media.sh --play"), { locked = true }) -- Play/pause playback
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/media.sh --play"), { locked = true }) -- Pause playback
hl.bind("ALT + Escape",  hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/media.sh --play"), { locked = true }) -- Play/pause playback (Alt + Escape)
hl.bind("ALT + SHIFT + Escape",  hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/media.sh --stop"), { locked = true }) -- Play/pause playback (Alt + Escape)

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" })) -- Previous workspace with mouse scroll up
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" })) -- Next workspace with mouse scroll down

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))        -- Switch to workspace
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i })) -- Move active window to workspace
end

-- Scroll through existing workspaces with mainMod + PgUp/PgDown
hl.bind(mainMod .. " + LEFT", hl.dsp.focus({ workspace = "e-1" })) -- Previous workspace
hl.bind(mainMod .. " + RIGHT",   hl.dsp.focus({ workspace = "e+1" })) -- Next workspace
hl.bind(mainMod .. " + H", hl.dsp.focus({ workspace = "e-1" })) -- Previous workspace
hl.bind(mainMod .. " + L",   hl.dsp.focus({ workspace = "e+1" })) -- Next workspace
hl.bind(mainMod .. " + UP",   hl.dsp.focus({ workspace = "e-1" })) -- Previous workspace with Page Up
hl.bind(mainMod .. " + DOWN", hl.dsp.focus({ workspace = "e+1" })) -- Next workspace with Page Down
hl.bind(mainMod .. " + Page_Up",   hl.dsp.focus({ workspace = "e-1" })) -- Previous workspace with Page Up
hl.bind(mainMod .. " + Page_Down", hl.dsp.focus({ workspace = "e+1" })) -- Next workspace with Page Down
hl.bind(mainMod .. " + K",   hl.dsp.focus({ workspace = "e-1" })) -- Previous workspace with Page Up
hl.bind(mainMod .. " + J", hl.dsp.focus({ workspace = "e+1" })) -- Next workspace with Page Down

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + SHIFT + LEFT",  hl.dsp.focus({ direction = "left" }))   -- Focus window to the left
hl.bind(mainMod .. " + SHIFT + RIGHT", hl.dsp.focus({ direction = "right" })) -- Focus window to the right
hl.bind(mainMod .. " + SHIFT + H",  hl.dsp.focus({ direction = "left" }))   -- Focus window to the left
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.focus({ direction = "right" })) -- Focus window to the right

-- Resize windows with mainMod + ALT + arrow/Page keys
hl.bind(mainMod .. " + ALT + LEFT",   hl.dsp.window.resize({ x = -50, y =   0, relative = true }), { repeating = true }) -- Decrease window width
hl.bind(mainMod .. " + ALT + RIGHT",  hl.dsp.window.resize({ x =  50, y =   0, relative = true }), { repeating = true }) -- Increase window width
hl.bind(mainMod .. " + ALT + H",   hl.dsp.window.resize({ x = -50, y =   0, relative = true }), { repeating = true }) -- Decrease window width
hl.bind(mainMod .. " + ALT + L",  hl.dsp.window.resize({ x =  50, y =   0, relative = true }), { repeating = true }) -- Increase window width
hl.bind(mainMod .. " + ALT + UP",     hl.dsp.window.resize({ x =   0, y = -50, relative = true }), { repeating = true }) -- Decrease window height
hl.bind(mainMod .. " + ALT + DOWN",   hl.dsp.window.resize({ x =   0, y =  50, relative = true }), { repeating = true }) -- Increase window height
hl.bind(mainMod .. " + ALT + Page_Up",     hl.dsp.window.resize({ x =   0, y = -50, relative = true }), { repeating = true }) -- Decrease window height
hl.bind(mainMod .. " + ALT + Page_Down",   hl.dsp.window.resize({ x =   0, y =  50, relative = true }), { repeating = true }) -- Increase window height
hl.bind(mainMod .. " + ALT + K",     hl.dsp.window.resize({ x =   0, y = -50, relative = true }), { repeating = true }) -- Decrease window height
hl.bind(mainMod .. " + ALT + J",   hl.dsp.window.resize({ x =   0, y =  50, relative = true }), { repeating = true }) -- Increase window height

-- Zoom controls
local MAX_ZOOM = 3
local MIN_ZOOM = 1
local ZOOM_TOGGLE_FACTOR = 1.5

---@param offset number
---@return nil
local function zoom(offset)
    local current = hl.get_config("cursor.zoom_factor")
    if offset ~= nil then
        current = current + offset
    elseif current ~= MIN_ZOOM then
        current = MIN_ZOOM
    else
        current = ZOOM_TOGGLE_FACTOR
    end
    current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
    hl.config({ cursor = { zoom_factor = current } })
end

hl.bind(mainMod .. " + SHIFT + UP", function()
    zoom(0.5) -- Increase cursor zoom
end)
hl.bind(mainMod .. " + SHIFT + DOWN", function()
    zoom(-0.5) -- Decrease cursor zoom
end)
hl.bind(mainMod .. " + SHIFT + Page_Up", function()
    zoom(0.5) -- Increase cursor zoom
end)
hl.bind(mainMod .. " + SHIFT + Page_Down", function()
    zoom(-0.5) -- Decrease cursor zoom
end)
hl.bind(mainMod .. " + SHIFT + K", function()
    zoom(0.5) -- Increase cursor zoom
end)
hl.bind(mainMod .. " + SHIFT + J", function()
    zoom(-0.5) -- Decrease cursor zoom
end)

-- Zoom with a 3-finger horizontal swipe on the touchpad
hl.gesture({ fingers = 3, direction = "left", action = function() zoom(0.5) end })  -- Swipe right: zoom in
hl.gesture({ fingers = 3, direction = "right",  action = function() zoom(-0.5) end }) -- Swipe left: zoom out

-- Group mode management
hl.bind(mainMod .. " + Z", hl.dsp.group.toggle()) -- Toggle window group
hl.bind(mainMod .. " + CTRL + LEFT", hl.dsp.window.move({ into_group = "l" })) -- Move window into group on the left
hl.bind(mainMod .. " + CTRL + RIGHT", hl.dsp.window.move({ into_group = "r" })) -- Move window into group on the right
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.move({ into_group = "l" })) -- Move window into group on the left
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.move({ into_group = "r" })) -- Move window into group on the right
hl.bind(mainMod .. " + CTRL + UP", hl.dsp.window.move({ out_of_group = true })) -- Move window out of group
hl.bind(mainMod .. " + CTRL + DOWN", hl.dsp.window.move({ out_of_group = true })) -- Move window out of group
hl.bind(mainMod .. " + CTRL + Page_Up", hl.dsp.window.move({ out_of_group = true })) -- Move window out of group
hl.bind(mainMod .. " + CTRL + Page_Down", hl.dsp.window.move({ out_of_group = true })) -- Move window out of group
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.move({ out_of_group = true })) -- Move window out of group
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.move({ out_of_group = true })) -- Move window out of group
hl.bind(mainMod .. " + TAB", hl.dsp.group.next()) -- Focus next window in group
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.group.prev()) -- Focus previous window in group
