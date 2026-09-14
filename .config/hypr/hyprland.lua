-- Hyprland Lua config (Hyprland 0.55+), migrated from hyprland.conf

hl.env("TERMINAL", "footclient")

require("local/monitors")
require("local/execs")

local mainMod = "SUPER"

hl.config({
    input = {
        kb_options = "caps:swapescape",
        repeat_rate = 50,
        repeat_delay = 250,
        touchpad = {
            natural_scroll = true,
            disable_while_typing = true,
        },
    },
    general = {
        layout = "scrolling",
    },
    misc = {
        close_special_on_empty = true,
        focus_on_activate = true,
        on_focus_under_fullscreen = 1,
    },
})

-- Special workspaces
hl.window_rule({ match = { class = "khal" }, workspace = "special:messages" })
hl.window_rule({ match = { class = "aerc" }, workspace = "special:messages" })
hl.window_rule({ match = { class = "chrome-hpfldicfbfomlpcikngkocigghgafkph-Default" }, workspace = "special:messages" })

-- Specific window rules
hl.window_rule({
    name = "float_pavucontrol",
    match = { class = "^(org.pulseaudio.pavucontrol)$" },
    persistent_size = true,
    float = true,
    center = true,
})
hl.window_rule({ match = { class = "footclient" }, opacity = "0.9" })
hl.window_rule({
    name = "portal_dialogs",
    match = { class = "^(org\\.freedesktop\\.impl\\.portal\\.desktop\\.(hyprland|gtk)|[Xx]dg-desktop-portal-gtk)$" },
    float = true,
    center = true,
})

-- General
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("uwsm stop"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("loginctl lock-session"))

-- Launchers
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd("exec footclient"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("pkill fuzzel || fuzzel"))
hl.bind(mainMod .. " + GRAVE", hl.dsp.exec_cmd("/home/julian/.local/bin/fuzzel-window-switch"))
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))

-- Window management
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + V", hl.dsp.window.float())
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + SHIFT + mouse:272", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + Return", hl.dsp.layout("promote"))
hl.bind(mainMod .. " + J", hl.dsp.layout("focus left"))
hl.bind(mainMod .. " + K", hl.dsp.layout("focus right"))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " + L", hl.dsp.layout("colresize +conf"))
hl.bind(mainMod .. " + H", hl.dsp.layout("colresize -conf"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("pkill -USR1 wayba"))

-- Workspace management
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i, on_current_monitor = true }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end
hl.bind(mainMod .. " + Z", hl.dsp.workspace.toggle_special("messages"))
hl.bind(mainMod .. " + Tab", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + CTRL + Tab", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mainMod .. " + CTRL + SHIFT + Tab", hl.dsp.window.move({ workspace = "e-1" }))

-- Monitor management
hl.bind(mainMod .. " + W", hl.dsp.focus({ monitor = "+1" }))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.window.move({ monitor = "+1" }))

-- Computer specific binds
require("local/binds")