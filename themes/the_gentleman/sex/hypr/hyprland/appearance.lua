-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	general = {
		gaps_in = 6,
		gaps_out = 14,

		border_size = 2,

		col = {
			-- A neon sign: magenta into crimson, with the cyan of a car's door light; it turns slowly (see below)
			active_border = { colors = { "rgb(f03c96)", "rgb(8e1538)", "rgb(4fc3d9)", "rgb(f03c96)" }, angle = 45 },
			inactive_border = "rgb(2a1822)",
		},
	},

	decoration = {
		rounding = 14,
		rounding_power = 4,

		-- Tension: whatever you are not looking at falls into the dark
		dim_inactive = true,
		dim_strength = 0.3,

		shadow = {
			range = 30,
			render_power = 2,
			color = 0x66f03c96,
			color_inactive = 0xee0b0709,
		},

		-- Dark glass behind translucent windows (kitty) and Quickshell (see rules.lua)
		blur = {
			size = 8,
			passes = 3,
			brightness = 0.7,
			vibrancy = 0.4,
			popups = true,
		},
	},

	dwindle = {
		preserve_split = true,
	},

	misc = {
		-- The wallpaper is drawn by quickshell
		force_default_wallpaper = 0,
		background_color = "rgb(0b0709)",
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},
})

----------------------
---- ANIMATIONS ------
----------------------

-- A tease: windows come in slowly and go a little too far before settling, leave in a rush;
-- workspaces slide past like a body turning away, and the neon border never stops moving

hl.curve("tease", {
	type = "bezier",
	points = { { 0.34, 1.4 }, { 0.64, 1 } },
})

hl.curve("linger", {
	type = "bezier",
	points = { { 0.4, 0 }, { 0.2, 1 } },
})

hl.curve("rush", {
	type = "bezier",
	points = { { 0.6, 0 }, { 0.9, 0.4 } },
})

hl.curve("linear", {
	type = "bezier",
	points = { { 0, 0 }, { 1, 1 } },
})

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 6, bezier = "linger" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 100, bezier = "linear", style = "loop" })
hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "tease" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 6, bezier = "tease", style = "popin 70%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2.5, bezier = "rush", style = "popin 85%" })
hl.animation({ leaf = "fade", enabled = true, speed = 5, bezier = "linger" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 8, bezier = "linger" })
hl.animation({ leaf = "layers", enabled = true, speed = 4, bezier = "linger" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "linger", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 2, bezier = "rush", style = "fade" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "linger", style = "slidefadevert 20%" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "linger" })
