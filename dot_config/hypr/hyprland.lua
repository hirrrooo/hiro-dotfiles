-- Main Hyprland Configuration
-- Refer to https://wiki.hypr.land/Configuring/Start/

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function ()
    hl.exec_cmd("qs -c noctalia-shell")
    hl.exec_cmd("nm-applet &")
    hl.exec_cmd("blueman-applet &")
    hl.exec_cmd("hyprctl setcursor Notwaita-Gray 24 &")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'Notwaita-Gray' &")
    hl.exec_cmd("/usr/libexec/polkit-gnome-authentication-agent-1 &")
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets &")

    -- Warmup distrobox (dog-box)
    hl.exec_cmd("podman start dog-box")

    -- First Boot Setup (DogOS)
    hl.exec_cmd([[sh -c "if [ ! -f $HOME/.config/dog-os-setup.done ]; then kitty --hold sh -c 'ujust setup-os && touch $HOME/.config/dog-os-setup.done && echo \"Setup complete!\" && kitty --class dog-menu -e dog-menu'; fi"]])
end)


---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
local fileManager = "nautilus"
local browser     = "helium"
local music       = "com.spotify.Client"
local notes       = "md.obsidian.Obsidian"


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Notwaita-Gray")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Notwaita-Gray")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("PATH", "$HOME/.local/bin:$PATH")


-----------------
---- LAYOUTS ----
-----------------

hl.config({
    dwindle = {
        smart_split = true, -- window is conceptually divided into four triangles
    },
})


-------------------------
---- SCREENSHOT RULES ---
-------------------------

hl.layer_rule({
    match   = { namespace = "hyprpicker" },
    no_anim = true,
})

hl.layer_rule({
    match   = { namespace = "selection" },
    no_anim = true,
})


--------------------------
---- SOURCED MODULES -----
--------------------------

require("input")
require("looknfeel")
require("monitors")
require("windowrules")
require("keybinds")
