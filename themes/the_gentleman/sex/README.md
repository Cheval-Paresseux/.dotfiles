# Sex theme

The second room of *The Gentleman*: behind closed doors. Black leather with a wine
tint, the warmth of skin for text, and one neon magenta for whatever has your
attention, like the light in the back of a car at night. Status colours are the
safeword lights: green to go on, amber to slow down, red to stop. The rest is
tension: unfocused windows fall into the dark, the bar is a stitched strap held
by chrome rings, the workspace you are in beats like a heart, and titles are set
in Playfair's high-contrast italics, like a fashion magazine.

Switch to it with `SUPER + T` or `~/.dotfiles/scripts/switch-theme.sh sex`.

## How colour is used

| Level | Colour | Meaning | Examples |
|---|---|---|---|
| Structure | black and wine darks | backgrounds, borders, secondary text | panels, stitching, O-rings, line numbers |
| Content | skin `#f2e4e6` | what you are reading | file contents, titles, the clock |
| Focus | neon `#f03c96` | where you are, what is selected | active window border and glow, the beating heart, cursor, selected item, prompt directory, section titles, keywords, hovered bar icons |
| Info | cyan `#4fc3d9` | neutral information | notifications, connected devices, commands, URLs |
| Success | go `#6fd08c` | good / added | charging, git additions, successful command (♥), strings |
| Warning | tungsten `#f2a541` | needs attention | battery under 30%, git changes, search matches, the handcuffs on (keep awake) |
| Critical | stop `#ff4b3a` | error / destructive | errors, failed command (♥), muted audio, battery under 15%, shut down |
| Other | blush, crimson, UV violet, ice, glow | syntax highlighting and ornaments | numbers, operators, ribbons, filled hearts, float borders |

The room stays black: neon appears only where your attention is, and the safeword
lights only when something needs saying.

## Palette

| Neutral | Hex | Used for |
|---|---|---|
| crust | `#0b0709` | Quickshell bar, tmux status, text on accent |
| base | `#100a0d` | terminal background, kitty tab bar |
| mantle | `#160d12` | popups, cursor line |
| surface0 | `#1f1219` | buttons, ANSI black |
| surface1 | `#2a1822` | hovered rows, inactive borders |
| surface2 | `#3a2130` | selected rows, selection, borders |
| overlay0 | `#5c3a4b` | autosuggestions, empty hearts, bright black |
| overlay1 | `#7d5868` | comments, O-rings, disabled and hint text |
| subtext0 | `#b0909c` | secondary text, the date |
| subtext1 | `#d4b8c0` | muted text, ANSI white |
| text | `#f2e4e6` | skin: main text, bright white |

| Accent | Hex | ANSI (normal / bright) |
|---|---|---|
| stop | `#ff4b3a` | 1 / 9 (`#ff7a6b`) |
| go | `#6fd08c` | 2 / 10 (`#95e0aa`) |
| tungsten | `#f2a541` | 3 / 11 (glow `#f7c27a`) |
| UV | `#9b7cf2` | 4 / 12 (`#b8a2f7`) |
| neon | `#f03c96` | accent, 5 / 13 (blush `#f7a8c8`) |
| cyan | `#4fc3d9` | 6 / 14 (ice `#82d8e8`) |
| crimson | `#8e1538` | filled hearts, satin ribbons, float borders, the dark end of gradients |
| lace | `#c9a9b6` | parameters (Neovim) |

## Shapes, icons and words

- Tension: unfocused windows are dimmed hard and sink into a black shadow; the focused one wears a neon border (magenta, crimson, a touch of cyan) that turns slowly and never stops, and casts a magenta glow. Corners are rounded (14 px).
- Motion is a tease: windows come in slowly and overshoot a little before settling, leave in a rush; workspaces slide past like a body turning away.
- Dark glass: kitty, the bar, popups and toasts are translucent over a dark blur. Neovim and Yazi leave the background unset so the glass shows through.
- The bar is a black leather strap stitched in neon along both edges; its sections are held by chrome O-rings, like the hardware of a collar. Popups are stitched just inside their edge.
- The clock is set like a magazine cover: the day in spaced capitals, the hour in large Playfair italics.
- Workspaces are hearts: empty ones are outlines, occupied ones fill in crimson, and the one you are in beats in neon (lub-dub), faster the more windows it holds.
- Bar icons: the bed (wallpapers), lipstick (apps), handcuffs (keep awake: amber while they are on), sealed messages (notifications, closed eyes for Do Not Disturb), candle / night light / lights on (brightness), the door out (power).
- Popups: Chemistry (Wi-Fi) with Together and Strangers, Close contact (Bluetooth) with Familiar and Within reach, Whispers (audio), Mood lighting (brightness), Secrets (notifications, "Burn them" to clear), Stamina (battery) with its Pace: Gentle / Steady / Wild, and Aftercare (power).
- Pickers: "What do you desire?" (apps), "What you kept to yourself..." (clipboard), "Set the scene..." (wallpapers), "Change partners..." (themes).
- Empty lists show a faint object: a mask, an empty bed, a glass of wine.
- Lock screen: a neon glow pulsing like a slow heartbeat, a domino mask, BEHIND CLOSED DOORS, a large italic clock, and the password asked for as a safeword ("Say the word: your password.").
- Fish: a whisper that changes with the hour ("Still awake? Good. So am I.") and how long you have been together (the uptime). The prompt ends in a heart, green after a success and red after a failure.
- Neovim opens on a masquerade mask above a letter-spaced S E X; lualine sections are cut on a slant, like the line of lingerie. kitty and tmux tabs are slanted too, the current one in neon; tmux windows are set apart by hearts.
- Wallpapers: the back seat in magenta and cyan (the default), the bed by lamplight, the red floor, the brick wall.
- Theme picker: a black satin masquerade mask trimmed in neon, crimson ribbons falling from its ties.

## Fonts

- Monospace and icons: **MesloLGM Nerd Font** (`ttf-meslo-nerd`)
- Clock, popup titles and lock screen: **Playfair** at a large optical size (`ttf-playfair-variable`, AUR)
- Interface: system sans-serif

## Where each app gets it

| App | File |
|---|---|
| Quickshell | `quickshell/config/Theme.qml`, `quickshell/config/Icons.qml`, `quickshell/assets/emblem.svg` (the theme in the theme picker), `modules/bar/BarRing.qml` (the O-rings), `modules/bar/WorkspaceList.qml` (the hearts), `components/EmptyState.qml` (empty lists) |
| Hyprland | `hypr/hyprland/appearance.lua`, `hypr/hyprland/rules.lua` (glass under Quickshell) |
| Kitty | `kitty/kitty.conf` (the 16 ANSI colours, inherited by eza, bat and other CLI tools) |
| Fish | `fish/conf.d/theme.fish`, `fish/functions/` |
| Tmux | `tmux/tmux.conf` |
| Yazi | `yazi/theme.toml` |
| Neovim | `nvim/lua/config/palette.lua`, `nvim/lua/plugins/colorscheme.lua`, `nvim/lua/plugins/snacks.lua` (dashboard), `nvim/lua/plugins/ui.lua` (lualine) |
