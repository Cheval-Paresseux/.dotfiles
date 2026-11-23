-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 6,

		border_size = 2,

		col = {
			active_border = { colors = { "rgb(e32b36)", "rgb(8f1820)" }, angle = 90 }, -- saber fading into the hull
			inactive_border = "rgb(24282e)",
		},
	},

	decoration = {
		-- Unfocused windows fall into shadow
		dim_inactive = true,
		dim_strength = 0.2,

		-- The focused window glows red, the others cast a plain shadow
		shadow = {
			range = 12,
			color = 0x66e32b36,
			color_inactive = 0xee08090b,
		},
	},

	dwindle = {
		preserve_split = true,
	},

	misc = {
		-- The wallpaper is drawn by quickshell
		force_default_wallpaper = 0,
		background_color = "rgb(0d0f12)",
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},
})

----------------------
---- ANIMATIONS ------
----------------------

-- Heavy machinery: windows slam into place with a short overshoot,
-- workspaces move like blast doors, and nothing lingers

hl.curve("slam", {
	type = "bezier",
	points = { { 0.2, 1.15 }, { 0.3, 1 } },
})

hl.curve("piston", {
	type = "bezier",
	points = { { 0.85, 0 }, { 0.15, 1 } },
})

hl.curve("snap", {
	type = "bezier",
	points = { { 0.1, 0.9 }, { 0.2, 1 } },
})

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 3, bezier = "snap" })
hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "slam" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "slam", style = "popin 80%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2, bezier = "snap", style = "popin 80%" })
hl.animation({ leaf = "fade", enabled = true, speed = 2.5, bezier = "snap" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 2.5, bezier = "snap", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 2, bezier = "snap", style = "fade" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "piston", style = "slide" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 5, bezier = "snap" })
