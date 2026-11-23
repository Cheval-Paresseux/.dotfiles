-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 10,

		border_size = 2,

		col = {
			active_border = { colors = { "rgb(f2a65a)", "rgb(d2734a)" }, angle = 45 }, -- twin suns
			inactive_border = "rgb(372b21)",
		},
	},

	decoration = {
		rounding = 10,
		rounding_power = 3,

		shadow = {
			color = 0xee130e0a,
		},

		-- Frosted glass behind translucent windows (kitty) and Quickshell (see rules.lua)
		blur = {
			variant = 1, -- frost
			size = 6,
			passes = 3,
			noise = 0.03,
			vibrancy = 0.25,
			popups = true,
		},
	},

	dwindle = {
		preserve_split = true,
	},

	misc = {
		-- The wallpaper is drawn by quickshell
		force_default_wallpaper = 0,
		background_color = "rgb(18120d)",
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},
})

----------------------
---- ANIMATIONS ------
----------------------

-- Desert motion: windows rise out of the haze, workspaces drift like sand,
-- and the twin-sun gradient sweeps round a newly focused window

hl.curve("drift", {
	type = "bezier",
	points = { { 0.22, 1 }, { 0.36, 1 } },
})

hl.curve("haze", {
	type = "bezier",
	points = { { 0.4, 0 }, { 0.2, 1 } },
})

hl.curve("dune", {
	type = "spring",
	mass = 1,
	stiffness = 180,
	damping = 22,
})

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 6, bezier = "drift" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "drift" })
hl.animation({ leaf = "windows", enabled = true, speed = 5, spring = "dune" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 5, spring = "dune", style = "slide bottom" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2.5, bezier = "haze", style = "popin 92%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 3, bezier = "haze" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 2.5, bezier = "haze" })
hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "haze" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3.5, bezier = "drift", style = "popin 94%" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 2, bezier = "haze", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 2.5, bezier = "haze" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 2, bezier = "haze" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "drift", style = "slidefadevert 20%" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "drift" })
