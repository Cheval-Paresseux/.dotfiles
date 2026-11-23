-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 12,

		border_size = 2,

		col = {
			-- Antique gilt: pale where it catches the lamp, darkened gold at the base
			active_border = { colors = { "rgb(e3cf9c)", "rgb(c8a96a)", "rgb(7d6535)" }, angle = 135 },
			inactive_border = "rgb(1f2a23)",
		},
	},

	decoration = {
		rounding = 10,
		rounding_power = 3,

		-- Lumière tamisée: the focused window sits in a faint glow, the others sink into the dark
		dim_inactive = true,
		dim_strength = 0.15,

		shadow = {
			range = 22,
			render_power = 3,
			color = 0x26c8a96a,
			color_inactive = 0xdd0a0d0b,
		},

		-- Smoked glass behind translucent windows (kitty) and Quickshell (see rules.lua)
		blur = {
			size = 7,
			passes = 3,
			brightness = 0.8,
			noise = 0.025,
			vibrancy = 0.2,
			popups = true,
		},
	},

	dwindle = {
		preserve_split = true,
	},

	misc = {
		-- The wallpaper is drawn by quickshell
		force_default_wallpaper = 0,
		background_color = "rgb(0a0d0b)",
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},
})

----------------------
---- ANIMATIONS ------
----------------------

-- Unhurried, like a slow pour: windows settle in softly, workspaces fade like
-- moving to another room of the lounge, and the light shifts over a newly focused window

hl.curve("pour", {
	type = "bezier",
	points = { { 0.25, 1 }, { 0.3, 1 } },
})

hl.curve("linger", {
	type = "bezier",
	points = { { 0.45, 0 }, { 0.55, 1 } },
})

hl.curve("settle", {
	type = "spring",
	mass = 1,
	stiffness = 170,
	damping = 24,
})

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 6, bezier = "pour" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "linger", style = "once" })
hl.animation({ leaf = "windows", enabled = true, speed = 5, spring = "settle" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 5, spring = "settle", style = "popin 92%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2.5, bezier = "linger", style = "popin 92%" })
hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "linger" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 6, bezier = "linger" })
hl.animation({ leaf = "layers", enabled = true, speed = 4, bezier = "pour" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "pour", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 2.5, bezier = "linger", style = "fade" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "linger", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "pour" })
