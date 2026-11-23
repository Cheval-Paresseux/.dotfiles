----------------------
---- WINDOW RULES ----
----------------------

-- Apps cannot maximize themselves; layout is decided by Hyprland
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

-- Office glass under the bar, its popups, the notifications and the pickers
hl.layer_rule({
	name = "blur-quickshell",
	match = { namespace = "^quickshell(-(launcher|clipboard|wallpaper|theme))?$" },
	blur = true,
	blur_popups = true,
	ignore_alpha = 0.1,
})
