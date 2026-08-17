-- https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.env("GDK_SCALE", "1")

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})

hl.monitor({
    output   = "desc: Dell Inc. DELL G2723HN",
    mode     = "1920x1080@165",
    position = "0x0",
    scale    = 1,
})

hl.monitor({
    output    = "DP-6",
    mode      = "1920x1080@60",
    position  = "1920x-1030",
    scale     = 1,
    transform = 3,
})

hl.workspace_rule({
    workspace  = "name:vertical",
    monitor    = "DP-6",
    default    = true,
    persistent = true,
})
