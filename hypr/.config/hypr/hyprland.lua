require("hyprland/binds")
require("hyprland/devices")
require("hyprland/laptop")
require("hyprland/looks")
require("hyprland/misc")
require("hyprland/windows")

--- Autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("swaync")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("antimicrox --hidden")
    hl.exec_cmd("steam -silent")
    hl.exec_cmd("vesktop --start-minimized")

    -- Waybar related
    hl.exec_cmd("waybar")
end)

--- Env Vars
hl.env("XCURSOR_SIZE", 24)
hl.env("HYPRCURSOR_SIZE", 24)
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_STYLE_OVERRIDE", "kvantum")

--- Input
hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})
