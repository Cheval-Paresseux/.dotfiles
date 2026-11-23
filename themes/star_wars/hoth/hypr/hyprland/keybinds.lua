---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

-- Applications
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("kitty -e yazi"))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("zen-browser"))

-- Shell (Quickshell IPC)
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("qs ipc call launcher toggle"))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("qs ipc call clipboard toggle"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("qs ipc call wallpaper toggle"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("qs ipc call theme toggle"))
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("qs ipc call power toggle"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("qs ipc call lock lock"))

-- Windows
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

for _, direction in ipairs({ "left", "right", "up", "down" }) do
	hl.bind(mainMod .. " + " .. direction, hl.dsp.focus({ direction = direction }))
end

-- Workspaces: SUPER + [0-9] to switch, SUPER + SHIFT + [0-9] to move the window
for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Scratchpad
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Screenshots: region to clipboard, or full screen to ~/Pictures/Screenshots
hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp -d)" - | wl-copy --type image/png'))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd('mkdir -p ~/Pictures/Screenshots && grim ~/Pictures/Screenshots/"$(date +%Y-%m-%d_%H-%M-%S)".png'))

-------------------------
---- MULTIMEDIA KEYS ----
-------------------------

local hold = { locked = true, repeating = true }
local press = { locked = true }

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), hold)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), hold)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), press)
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), press)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), hold)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), hold)

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), press)
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), press)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), press)
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), press)
