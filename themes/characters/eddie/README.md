# Eddie theme

Eddie's club, in *Characters*: a private room after hours, in the quiet luxury
of old money. Nothing here asks to be noticed. The room is bottle-green velvet in
the dark and ivory paper, antique gold marks whatever has your attention, and the
rest of the club lends its colours sparingly and muted: sage, blue-grey smoke,
cognac and claret. Light is low (lumière tamisée): the focused window sits in a
faint glow, the others sink into the dark. Titles are set in Playfair's
high-contrast serif and italics, like a drinks menu.

Switch to it with `SUPER + T` or `~/.dotfiles/scripts/switch-theme.sh eddie`.

## How colour is used

| Level | Colour | Meaning | Examples |
|---|---|---|---|
| Structure | bottle-green darks | backgrounds, borders, secondary text | panels, separators, line numbers |
| Content | ivory `#e4dcc8` | what you are reading | file contents, titles |
| Focus | antique gold `#c8a96a` | where you are, what is selected | active window border and glow, the poured workspace glass, the clock's hour, cursor, selected item, prompt directory, section titles, keywords, hovered bar icons, the record while it plays |
| Info | slate `#8b9cab` | neutral information | notifications, connected guests (Bluetooth), functions, commands |
| Success | sage `#88a878` | good / added | charging, git additions, successful command (❧), strings |
| Warning | cognac `#c98a4b` | needs attention | battery under 30%, git changes, search matches, types, the lit cigar (keep awake) |
| Critical | claret `#b24a4f` | error / destructive | errors, failed command (❧), muted audio, battery under 15%, shut down |
| Other | pale gold, old gold, heather, verdigris, camel | syntax highlighting and ornaments | numbers, operators, parameters, fleurons and rules, gilt gradients |

Every accent is kept muted and close in value, so the room stays calm: colour is a
detail you find, not something that calls out.

## Palette

| Neutral | Hex | Used for |
|---|---|---|
| crust | `#0a0d0b` | Quickshell bar, tmux status, text on accent |
| base | `#0e1210` | terminal background, kitty tab bar |
| mantle | `#121815` | popups, cursor line |
| surface0 | `#18201b` | buttons, ANSI black |
| surface1 | `#1f2a23` | hovered rows, inactive borders |
| surface2 | `#2a372e` | selected rows, selection, borders, empty-list emblems |
| overlay0 | `#45524a` | autosuggestions, bright black |
| overlay1 | `#66716a` | comments, disabled and hint text |
| subtext0 | `#9a9f94` | secondary text, the date |
| subtext1 | `#c2bfae` | muted text, ANSI white |
| text | `#e4dcc8` | ivory: main text, bright white |

| Accent | Hex | ANSI (normal / bright) |
|---|---|---|
| claret | `#b24a4f` | 1 / 9 (`#c96a6c`) |
| sage | `#88a878` | 2 / 10 (`#a3bf93`) |
| gold | `#c8a96a` | accent, 3 / 11 (pale gold `#e3cf9c`) |
| slate | `#8b9cab` | 4 / 12 (`#a8b6c2`) |
| heather | `#9c7f9a` | 5 / 13 (`#b79db4`) |
| verdigris | `#6f9a8e` | 6 / 14 (`#8db5a9`) |
| cognac | `#c98a4b` | |
| pale gold | `#e3cf9c` | the light end of gilt gradients |
| old gold | `#7d6535` | fleurons, rules, float borders, the dark end of gilt gradients |
| camel | `#b89a72` | parameters (Neovim) |

## Shapes, icons and words

- Lumière tamisée: unfocused windows are dimmed, the focused one has an antique gilt border and a faint gold glow, like the glass under the lamp. Corners are softly rounded (10 px), gaps generous.
- Smoked glass: kitty, the bar, popups and toasts are translucent over a dark, slightly grainy blur. Neovim and Yazi leave the background unset so the glass shows through.
- The bar is the counter: smoked glass under a gilt rail worn bright where the lamp falls, and a faint pool of lamplight behind the clock in the middle.
- The clock is set like a menu card: the day in serif italics, the hour in gold serif figures, between two fleurons (❧ ☙). Sections are set apart by small gilt fleurons (❦).
- Workspaces are tumblers on the counter: each fills with the windows it holds, and the one you are in is poured to the brim in gold.
- The turntable: what is playing (any MPRIS player) is shown in italics next to a record that turns at 33⅓ while the music plays. Click to pause or play, scroll to change track.
- Motion is an unhurried pour: windows settle in softly, workspaces fade like moving to another room, the light sweeps once over a newly focused window.
- Bar icons: armchair (wallpapers), the bottles behind the bar (apps), a cigar (keep awake: lit while it is on), the front desk's bell (notifications, a closed door for Do Not Disturb), candle / lamp / candelabra (brightness), the door out (power).
- Popups: The wire (Wi-Fi) with its lines, The guest list (Bluetooth) with Regulars and At the door, The gramophone (audio), Lamplight (brightness), The silver tray (notifications), The decanter (battery) with its pour, Sip / Dram / Double, and Last call (power).
- Pickers: "What will it be tonight?" (apps, "Not on the menu" when nothing matches), the notebook (clipboard), scenes (wallpapers), rooms (themes).
- Empty lists show a faint object from the lounge: an empty tray, an empty armchair, a glass.
- Lock screen: the lamp above the door, its light breathing like a flame; a glass, MEMBERS ONLY, a large serif clock, the date in italics, and "The door is closed. Password, please."
- Fish: the barman greets you according to the hour, and reads the session's uptime like an age statement ("this session, aged 2 h 14 min"). The prompt ends in a fleuron, sage after a success and claret after a failure.
- Neovim opens on a smoking tumbler above a letter-spaced EDDIE, between fleurons; lualine sections have rounded ends like leather tabs. kitty and tmux tabs are separated by gilt fleurons, the current one in gold italics.
- Wallpapers: a glass and a cigar under the lamp (the default), a record on the turntable, a guest in the armchair.
- Theme picker: the Characters themes appear as objects from their scene, in a row of their own; this one is a snifter holding a dram, smoke drifting over the rim, in a pool of lamplight.

## Fonts

- Monospace and icons: **MesloLGM Nerd Font** (`ttf-meslo-nerd`)
- Clock, popup titles, italics and lock screen: **Playfair** in its Display cut (`ttf-playfair-variable`, AUR)
- Interface: system sans-serif

## Where each app gets it

| App | File |
|---|---|
| Quickshell | `quickshell/config/Theme.qml`, `quickshell/config/Icons.qml`, `quickshell/assets/emblem.svg` (the theme in the theme picker), `modules/bar/BarDivider.qml` (the fleurons), `modules/bar/NowPlaying.qml` (the turntable), `components/EmptyState.qml` (empty lists) |
| Hyprland | `hypr/hyprland/appearance.lua`, `hypr/hyprland/rules.lua` (glass under Quickshell) |
| Kitty | `kitty/kitty.conf` (the 16 ANSI colours, inherited by eza, bat and other CLI tools) |
| Fish | `fish/conf.d/theme.fish`, `fish/functions/` |
| Tmux | `tmux/tmux.conf` |
| Yazi | `yazi/theme.toml` |
| Neovim | `nvim/lua/config/palette.lua`, `nvim/lua/plugins/colorscheme.lua`, `nvim/lua/plugins/snacks.lua` (dashboard), `nvim/lua/plugins/ui.lua` (lualine) |
