------------------
---- MONITORS ----
------------------

hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1.25,
})

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
	-- Shell: bar, wallpaper, launcher, notifications, lock screen
	hl.exec_cmd("qs")

	-- Polkit agent and idle daemon run as systemd user services (one instance each)
	hl.exec_cmd("systemctl --user start hyprpolkitagent.service hypridle.service")

	-- Clipboard history
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")

	-- GTK dark mode
	hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface monospace-font-name 'MesloLGM Nerd Font 10'")
end)

-----------------------
---- LOAD MODULES -----
-----------------------

require("hyprland.appearance")
require("hyprland.input")
require("hyprland.keybinds")
require("hyprland.rules")
