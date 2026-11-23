-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 8,

		border_size = 2,

		col = {
			active_border = { colors = { "rgb(f0d9a0)", "rgb(d8b26e)", "rgb(8c6a32)" }, angle = 135 }, -- polished gold
			inactive_border = "rgb(1e2330)",
		},
	},

	decoration = {
		-- A soft halo of gold around the focused window, the others stand in the dark
		shadow = {
			range = 24,
			render_power = 2,
			color = 0x40d8b26e,
			color_inactive = 0xcc07080c,
		},

		-- Champagne-tinted glass behind translucent windows (kitty) and Quickshell (see rules.lua)
		blur = {
			variant = 8, -- acrylic
			passes = 2,
			popups = true,
			acrylic = {
				tint = 0x14d8b26e,
			},
		},
	},

	dwindle = {
		preserve_split = true,
	},

	misc = {
		-- The wallpaper is drawn by quickshell
		force_default_wallpaper = 0,
		background_color = "rgb(0b0d13)",
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},
})

----------------------
---- ANIMATIONS ------
----------------------

-- Velvet lifts: windows rise and settle without a jolt, workspaces glide
-- between floors, and everything fades in like lights coming up in a lobby

hl.curve("velvet", {
	type = "bezier",
	points = { { 0.22, 1 }, { 0.36, 1 } },
})

hl.curve("hush", {
	type = "bezier",
	points = { { 0.65, 0 }, { 0.35, 1 } },
})

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 8, bezier = "velvet" })
hl.animation({ leaf = "windows", enabled = true, speed = 6, bezier = "velvet" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 6, bezier = "velvet", style = "slide bottom" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "hush", style = "popin 95%" })
hl.animation({ leaf = "fade", enabled = true, speed = 6, bezier = "hush" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 5, bezier = "velvet", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 3, bezier = "hush", style = "fade" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 7, bezier = "velvet", style = "slidefadevert 20%" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 6, bezier = "velvet" })
