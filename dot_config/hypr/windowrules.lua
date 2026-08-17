-- Window Rules Configuration
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Global Rules
hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

-- dog-menu
hl.window_rule({
    name   = "dog-menu",
    match  = { class = "^dog-menu$" },
    float  = true,
    center = true,
    size   = { 800, 600 },
})

-- Bitwarden
hl.window_rule({
    name   = "Bitwarden",
    match  = { class = "^chrome-nngceckbapebfimnlniiiahkandclblb-Default$" },
    float  = true,
    center = true,
    size   = { "(monitor_w*0.2)", "(monitor_h*0.4)" },
})

-- Nautilus
hl.window_rule({
    name   = "Nautilus",
    match  = { class = "^org.gnome.Nautilus$" },
    float  = true,
    center = true,
    size   = { 800, 600 },
})

-- Kitty
hl.window_rule({
    name   = "Kitty",
    match  = { class = "^kitty$" },
    float  = true,
    center = true,
    size   = { 800, 600 },
})

-- Todoist
hl.window_rule({
    name   = "Todoist",
    match  = { class = "^Todoist$" },
    float  = true,
    center = true,
    size   = { 800, 600 },
})

-- Open Files (File Chooser)
hl.window_rule({
    name   = "Open Files",
    match  = { title = "^Open Files?$" },
    float  = true,
    center = true,
    size   = { 800, 600 },
})

-- Window rules for the Boot to Windows script
hl.window_rule({
    name      = "Boot to Windows Popup",
    match     = { class = "^boot-windows$" },
    float     = true,
    center    = true,
    size      = { 650, 300 },
    animation = "popin",
})
