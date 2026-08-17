local primary        = "rgb(b1cada)"
local surface        = "rgb(121314)"
local secondary      = "rgb(bfc8cf)"
local err            = "rgb(ffb4ab)"
local tertiary       = "rgb(d3c0dc)"
local surface_lowest = "rgb(0d0e0f)"

hl.config({
    general = {
        col = {
            active_border   = primary,
            inactive_border = surface,
        },
    },

    group = {
        col = {
            border_active          = secondary,
            border_inactive        = surface,
            border_locked_active   = err,
            border_locked_inactive = surface,
        },

        groupbar = {
            col = {
                active          = secondary,
                inactive        = surface,
                locked_active   = err,
                locked_inactive = surface,
            },
        },
    },
})
