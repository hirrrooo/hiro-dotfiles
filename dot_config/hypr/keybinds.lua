-- Keybinds Configuration
-- See https://wiki.hypr.land/Configuring/Basics/Binds/

local mainMod     = "SUPER"
local ipc         = "qs -c noctalia-shell ipc call"

local terminal    = "kitty"
local fileManager = "nautilus"
local browser     = "helium"
local music       = "com.spotify.Client"
local notes       = "md.obsidian.Obsidian"

-- Reboot to Windows popup
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("kitty --class boot-windows -T 'Boot Windows' ujust boot-windows"))

-- Core application & window binds
hl.bind(mainMod .. " + T",         hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q",         hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())
hl.bind("CTRL + SHIFT + Escape",   hl.dsp.exec_cmd("kitty --class dog-menu -e dog-menu"))
hl.bind(mainMod .. " + E",         hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + F",         hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + N",         hl.dsp.exec_cmd("flatpak run " .. notes))
hl.bind(mainMod .. " + M",         hl.dsp.exec_cmd("flatpak run " .. music))
hl.bind(mainMod .. " + P",         hl.dsp.window.pseudo())
hl.bind(mainMod .. " + B",         hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + R",         hl.dsp.exec_cmd("~/.config/hypr/scripts/hypr-restart-app.sh"))
-- hl.bind(mainMod .. " + L",      hl.dsp.exec_cmd("hyprlock"))

-- Fake Fullscreen for browsers
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen_state({ internal = 0, client = 3 }))
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.window.fullscreen_state({ internal = 2 }))

-- Next/Previous Workspace
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("~/.config/hypr/scripts/monitor-scroll.sh next"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("~/.config/hypr/scripts/monitor-scroll.sh prev"))

-- Noctalia Bindings
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(ipc .. " launcher toggle"))
hl.bind(mainMod .. " + C",     hl.dsp.exec_cmd(ipc .. " controlCenter toggle"))
hl.bind(mainMod .. " + comma", hl.dsp.exec_cmd(ipc .. " settings toggle"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. " volume increase"),   { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. " volume decrease"),   { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd(ipc .. " volume muteOutput"), { locked = true })
hl.bind(mainMod .. " + V",     hl.dsp.exec_cmd(ipc .. " launcher clipboard"))
hl.bind(mainMod .. " + L",     hl.dsp.exec_cmd(ipc .. " lockScreen lock"))

-- Screenshot with HyprQuickFrame
hl.bind("print",                   hl.dsp.exec_cmd("quickshell -c HyprQuickFrame -n"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("env HQF_MODE=region quickshell -c HyprQuickFrame -n"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("env HQF_MODE=window quickshell -c HyprQuickFrame -n"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "d" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + TAB",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Media controls (requires playerctl)
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86_AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
-- hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- code-server
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("kitty --title code-server -e zsh -ic 'code-server'"))
