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

hl.window_rule({
    match = {
        class = "launch-box",
    },
    float = true,
    size = { 800, 60 },
    center = true,
    pin = true,
    stay_focused = true,
    max_size = { 800, 60 },
    min_size = { 800, 60 },
    dim_around = true,
    xray = true,
})

hl.layer_rule({
    name = "blur-waybar",
    match = { namespace = "^waybar$" },

    blur = true,
    xray = true,
})

hl.layer_rule({
    name = "blur-swaync-notifications",
    match = { namespace = "^swaync-notification-window$" },

    blur = true,
    xray = true,
    ignore_alpha = 0,
})

hl.layer_rule({
    name = "blur-swaync-control-center",
    match = { namespace = "^swaync-control-center$" },

    blur = true,
    xray = true,
    ignore_alpha = 0,
})

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})
