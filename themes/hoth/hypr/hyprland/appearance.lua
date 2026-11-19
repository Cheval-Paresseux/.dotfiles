-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 8,

		border_size = 2,

		col = {
			active_border = { colors = { "rgb(d9581f)", "rgb(2f73c0)" }, angle = 135 }, -- the Rebels' orange meeting the saber's blue
			inactive_border = "rgb(bccad8)",
		},
	},

	decoration = {
		rounding = 6,

		shadow = {
			range = 14,
			color = 0x551f2a37,
		},

		-- Ice-faceted glass behind translucent windows (kitty) and Quickshell (see rules.lua)
		blur = {
			variant = 6, -- prism
			size = 6,
			passes = 3,
			brightness = 1.05,
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
		background_color = "rgb(f4f7fa)",
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},
})

----------------------
---- ANIMATIONS ------
----------------------

-- Cold and sharp: windows glide in on the wind, workspaces sweep sideways like a blizzard,
-- and the border's two colours turn round a newly focused window as if crossing sabers

hl.curve("glide", {
	type = "bezier",
	points = { { 0.2, 1 }, { 0.3, 1 } },
})

hl.curve("gust", {
	type = "bezier",
	points = { { 0.6, 0 }, { 0.2, 1 } },
})

hl.curve("drift", {
	type = "spring",
	mass = 1,
	stiffness = 200,
	damping = 24,
})

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5, bezier = "glide" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 25, bezier = "glide" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.5, spring = "drift" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.5, spring = "drift", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2.5, bezier = "gust", style = "popin 90%" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.5, bezier = "gust" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3.5, bezier = "glide", style = "popin 94%" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 2, bezier = "gust", style = "fade" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "gust", style = "slidefade 15%" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "glide" })
