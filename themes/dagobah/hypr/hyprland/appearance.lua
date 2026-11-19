-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	general = {
		gaps_out = 10,

		border_size = 2,

		col = {
			active_border = { colors = { "rgb(6cb6ff)", "rgb(7cc4b8)" }, angle = 45 }, -- saber light in the mist
			inactive_border = "rgb(22332e)",
		},
	},

	decoration = {
		rounding = 14,

		shadow = {
			range = 16,
			color = 0xaa0a1110,
		},

		-- Rain-streaked glass behind translucent windows (kitty) and Quickshell (see rules.lua);
		-- the drops stand still, since animating them costs a lot of GPU
		blur = {
			variant = 3, -- drops
			size = 7,
			passes = 3,
			vibrancy = 0.3,
			popups = true,
			drops = {
				speed = 0,
			},
		},
	},

	dwindle = {
		preserve_split = true,
	},

	misc = {
		-- The wallpaper is drawn by quickshell
		force_default_wallpaper = 0,
		background_color = "rgb(0e1715)",
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},
})

----------------------
---- ANIMATIONS ------
----------------------

-- Patient motion: windows rise out of the mist and settle softly,
-- workspaces drift like fog, and the saber light sweeps round a focused window

hl.curve("settle", {
	type = "bezier",
	points = { { 0.16, 1 }, { 0.3, 1 } },
})

hl.curve("mist", {
	type = "bezier",
	points = { { 0.45, 0 }, { 0.25, 1 } },
})

hl.curve("float", {
	type = "spring",
	mass = 1,
	stiffness = 120,
	damping = 18,
})

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 8, bezier = "settle" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 40, bezier = "settle" })
hl.animation({ leaf = "windows", enabled = true, speed = 6, spring = "float" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 6, spring = "float", style = "popin 90%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "mist", style = "popin 90%" })
hl.animation({ leaf = "fade", enabled = true, speed = 5, bezier = "mist" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "settle", style = "popin 95%" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 2.5, bezier = "mist", style = "fade" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "settle", style = "slidefadevert 15%" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "settle" })
