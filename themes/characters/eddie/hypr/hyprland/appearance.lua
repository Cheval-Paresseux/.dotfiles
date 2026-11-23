-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	general = {
		gaps_in = 6,
		gaps_out = 14,

		border_size = 2,

		col = {
			-- The hunting coat: scarlet, a shade deeper in the folds
			active_border = { colors = { "rgb(c8432c)", "rgb(9e3322)" }, angle = 90 },
			inactive_border = "rgb(2d2921)",
		},
	},

	-- Matte, like waxed cotton and oak: no glass, windows rest on a soft, heavy shadow
	decoration = {
		rounding = 4,

		blur = {
			enabled = false,
		},
		shadow = {
			range = 18,
			render_power = 3,
			offset = { 0, 4 },
			color = 0xcc000000,
			color_inactive = 0x88000000,
		},
	},

	dwindle = {
		preserve_split = true,
	},

	misc = {
		-- The wallpaper is drawn by quickshell
		force_default_wallpaper = 0,
		background_color = "rgb(15130e)",
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},
})

----------------------
---- ANIMATIONS ------
----------------------

-- A steady canter across the estate: windows come in at an even pace and settle without fuss,
-- leave with a nod, and workspaces ride past like the next field over the hedge

hl.curve("canter", {
	type = "bezier",
	points = { { 0.22, 1 }, { 0.36, 1 } },
})

hl.curve("nod", {
	type = "bezier",
	points = { { 0.5, 0 }, { 0.75, 0.6 } },
})

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5, bezier = "canter" })
hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "canter" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.5, bezier = "canter", style = "popin 90%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2.5, bezier = "nod", style = "popin 90%" })
hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "canter" })
hl.animation({ leaf = "layers", enabled = true, speed = 4, bezier = "canter" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "canter", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 2.5, bezier = "nod", style = "fade" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "canter", style = "slidefade 20%" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "canter" })
