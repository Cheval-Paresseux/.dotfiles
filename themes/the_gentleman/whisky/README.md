# Whisky theme

The first room of *The Gentleman*: a private lounge after hours, lumière tamisée.
A glass of whisky under a single lamp, a cigar resting in the ashtray, a record
turning, a guest in an old armchair. The room is tobacco-dark wood and cream,
amber whisky marks whatever has your attention, and the rest of the lounge lends
its colours sparingly: bottle-green velvet, blue-grey smoke, a cigar's ember and
a glass of wine. Light is low and warm: the focused window glows, the others sink
into the dark. Titles are set in Playfair's high-contrast serif and italics, like a drinks menu.

Switch to it with `SUPER + T` or `~/.dotfiles/scripts/switch-theme.sh whisky`.

## How colour is used

| Level | Colour | Meaning | Examples |
|---|---|---|---|
| Structure | tobacco darks | backgrounds, borders, secondary text | panels, separators, line numbers |
| Content | cream `#eadcc2` | what you are reading | file contents, titles, clock |
| Focus | amber `#e3a14e` | where you are, what is selected | active window border and glow, the poured workspace glass, cursor, selected item, prompt directory, section titles, keywords, hovered bar icons, the record while it plays |
| Info | smoke `#8da4bf` | neutral information | notifications, connected guests (Bluetooth), functions, commands |
| Success | velvet `#7aa874` | good / added | charging, git additions, successful command (❧), strings |
| Warning | ember `#e8743c` | needs attention | battery under 30%, git changes, search matches, types, the lit cigar (keep awake) |
| Critical | wine `#c94a52` | error / destructive | errors, failed command (❧), muted audio, battery under 15%, shut down |
| Other | honey, brass, rose, teal, tobacco | syntax highlighting and ornaments | numbers, operators, parameters, the clock's figures, fleurons and rules, gradients |

## Palette

| Neutral | Hex | Used for |
|---|---|---|
| crust | `#0c0907` | Quickshell bar, tmux status, text on accent |
| base | `#110d0a` | terminal background, kitty tab bar |
| mantle | `#17120e` | popups, cursor line |
| surface0 | `#201913` | buttons, ANSI black |
| surface1 | `#2a2119` | hovered rows, inactive borders |
| surface2 | `#382b20` | selected rows, selection, borders, empty-list emblems |
| overlay0 | `#5a4838` | autosuggestions, bright black |
| overlay1 | `#7a6652` | comments, disabled and hint text |
| subtext0 | `#a8957d` | secondary text, the date |
| subtext1 | `#cbb89c` | muted text, ANSI white |
| text | `#eadcc2` | cream: main text, bright white |

| Accent | Hex | ANSI (normal / bright) |
|---|---|---|
| wine | `#c94a52` | 1 / 9 (`#dc6b71`) |
| velvet | `#7aa874` | 2 / 10 (`#98c290`) |
| amber | `#e3a14e` | accent, 3 / 11 (honey `#f2c37d`) |
| smoke | `#8da4bf` | 4 / 12 (`#a9bdd3`) |
| rose | `#c9849b` | 5 / 13 (`#dca3b5`) |
| teal | `#6fa89a` | 6 / 14 (`#8fc2b5`) |
| ember | `#e8743c` | |
| honey | `#f2c37d` | the clock, the light end of gradients |
| brass | `#9a7038` | fleurons, rules, float borders, the dark end of gradients |
| tobacco | `#c79a6a` | parameters (Neovim) |

## Shapes, icons and words

- Lumière tamisée: unfocused windows are dimmed, the focused one has a honey-to-brass border and a soft amber glow, like the glass under the lamp. Corners are softly rounded (10 px), gaps generous.
- Smoked glass: kitty, the bar, popups and toasts are translucent over a dark, slightly grainy blur. Neovim and Yazi leave the background unset so the glass shows through.
- The bar is the counter: smoked glass under a brass rail polished where the lamp falls, and the lamp's warm pool of light behind the clock in the middle.
- The clock is set like a menu card: the day in serif italics, the hour in honey serif figures, between two fleurons (❧ ☙). Sections are set apart by small brass fleurons (❦).
- Workspaces are tumblers on the counter: each fills with the windows it holds, and the one you are in is poured to the brim in amber.
- The turntable: what is playing (any MPRIS player) is shown in italics next to a record that turns at 33⅓ while the music plays. Click to pause or play, scroll to change track.
- Motion is an unhurried pour: windows settle in softly, workspaces fade like moving to another room, the light sweeps once over a newly focused window.
- Bar icons: armchair (wallpapers), the bottles behind the bar (apps), a cigar (keep awake: lit while it is on), the front desk's bell (notifications, a closed door for Do Not Disturb), candle / lamp / candelabra (brightness), the door out (power).
- Popups: The wire (Wi-Fi) with its lines, The guest list (Bluetooth) with Regulars and At the door, The gramophone (audio), Lamplight (brightness), The silver tray (notifications), The decanter (battery) with its pour, Sip / Dram / Double, and Last call (power).
- Pickers: "What will it be tonight?" (apps, "Not on the menu" when nothing matches), the notebook (clipboard), scenes (wallpapers), rooms (themes).
- Empty lists show a faint object from the lounge: an empty tray, an empty armchair, a glass.
- Lock screen: the lamp above the door, its light breathing like a flame; a glass, MEMBERS ONLY, a large serif clock, the date in italics, and "The door is closed. Password, please."
- Fish: the barman greets you according to the hour, and reads the session's uptime like an age statement ("this session, aged 2 h 14 min"). The prompt ends in a fleuron, velvet after a success and wine after a failure.
- Neovim opens on a smoking tumbler above a letter-spaced WHISKY, between fleurons; lualine sections have rounded ends like leather tabs. kitty and tmux tabs are separated by brass fleurons, the current one in amber italics.
- Wallpapers: a glass and a cigar under the lamp (the default), a record on the turntable, a guest in the armchair.
- Theme picker: The Gentleman's themes appear as objects from their scene, in a row of their own; this one is a snifter holding a dram, smoke drifting over the rim, in a pool of lamplight.

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
