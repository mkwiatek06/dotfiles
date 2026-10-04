--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

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

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
    name  = "steam-games",
    match = { class = "steam_app_%d+" },
    fullscreen = true,
    stay_focused = true,
    workspace = 1,
    suppress_event = "fullscreen", "fullscreenoutput", "maximize"
})

hl.window_rule({
    name  = "native-games",
    match = { class = "tf_linux64||dontstarve_steam_x64||" },
    fullscreen = true,
    stay_focused = true,
    workspace = 1,
    suppress_event = "fullscreen", "fullscreenoutput", "maximize"
})

hl.window_rule({
    name  = "gamescope",
    match = { class = "gamescope" },
    fullscreen = true,
    stay_focused = true,
    workspace = 1,
    suppress_event = "fullscreen", "fullscreenoutput", "maximize", "activewindow", "activewindow2", "minimized",
})

hl.window_rule({
    name  = "easyeffects",
    match = { class = "com.github.wwmm.easyeffects" },
    workspace = 8,
    no_initial_focus = true,
})

hl.window_rule({
    name  = "volume-control",
    match = { class = "com.saivert.pwvucontrol||org.pulseaudio.pavucontrol" },
    workspace = 8,
    no_initial_focus = true,
})

hl.window_rule({
    name  = "steam",
    match = { class = "steam" },
    workspace = 9,
    no_initial_focus = true,
})

hl.window_rule({
    name  = "discord",
    match = { class = "discord" },
    workspace = 10,
    no_initial_focus = true,
})
