----------------
---- INPUT ----
----------------

hl.config({
	input = {
		kb_layout = "us",
		kb_options = "ctrl:nocaps", -- Caps Lock acts as Ctrl
	},
})

----------------
---- GESTURES ----
----------------

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})
