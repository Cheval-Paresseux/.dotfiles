-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 12,

		border_size = 2,

		col = {
			active_border = { colors = { "rgb(d23a1e)", "rgb(9c1730)" }, angle = 45 }, -- the red cord, sun to crimson
			inactive_border = "rgb(c6bca8)",
		},
	},

	-- Printed, not glass: no blur, and a hard shadow of ink offset to the bottom right, like a woodblock print
	decoration = {
		blur = {
			enabled = false,
		},
		shadow = {
			sharp = true,
			offset = { 6, 6 },
			color = 0xff1e1a17,
			color_inactive = 0x401e1a17,
		},
	},

	dwindle = {
		preserve_split = true,
	},

	misc = {
		-- The wallpaper is drawn by quickshell
		force_default_wallpaper = 0,
		background_color = "rgb(f5f1e8)",
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},
})

----------------------
---- ANIMATIONS ------
----------------------

-- A sword fight with a beat: windows are drawn fast and overshoot a little, leave in a single cut,
-- workspaces slide past like a spin on the floor, and light runs along the border like a blade catching the sun
hl.curve("draw", {
	type = "bezier",
	points = { { 0.1, 1.1 }, { 0.2, 1 } },
})

hl.curve("cut", {
	type = "bezier",
	points = { { 0.7, 0 }, { 0.9, 0.4 } },
})

hl.curve("spin", {
	type = "bezier",
	points = { { 0.25, 1 }, { 0.3, 1 } },
})

hl.curve("footwork", {
	type = "spring",
	mass = 1,
	stiffness = 320,
	damping = 20,
})

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 4, bezier = "spin" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 12, bezier = "spin" })
hl.animation({ leaf = "windows", enabled = true, speed = 4, spring = "footwork" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3.5, bezier = "draw", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2, bezier = "cut", style = "popin 80%" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "spin" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3, bezier = "draw", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "cut", style = "fade" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3.5, bezier = "spin", style = "slide" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "spin" })
