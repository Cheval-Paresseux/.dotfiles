# Hoth theme

The ice moon where both sides meet: a light theme of snow and frozen greys
under slate text. Rebel orange marks what has your attention, and the two
sabers of the duel on the ice carry the rest: Luke's blue for information,
Vader's red for danger. Shapes sit between the square Empire and the soft
swamp, glass is frosted with ice crystals, and the wording belongs to a base
holding out against the cold and the walkers.

Switch to it with `SUPER + T` or `~/.dotfiles/scripts/switch-theme.sh hoth`.

## How colour is used

| Level | Colour | Meaning | Examples |
|---|---|---|---|
| Structure | snow and ice greys | backgrounds, borders, secondary text | panels, separators, line numbers |
| Content | slate `#1f2a37` | what you are reading | file contents, titles, clock |
| Focus | rebel `#d9581f` | where you are, what is selected | active window border (rebel → saber), active workspace, cursor, selected item, prompt directory, keywords |
| Info | saber `#2f73c0` | neutral information | alerts, connected droids, functions, commands |
| Success | tundra `#3f8a3a` | good / added | charging, git additions, successful command, strings |
| Warning | beacon `#a87b00` | needs attention | battery under 30%, git changes, search matches, types, heater on |
| Critical | vader `#c42f3a` | error / destructive | errors, muted audio, battery under 15%, shut down |
| Other | violet, glacier, steel, frost, hide | syntax highlighting and categories | numbers, regex, delimiters, fields, parameters, media files |

It is a light theme, so the usual roles flip: text on the accent is white, and
the ANSI colours are darkened to read on snow (ANSI "white" is a pale grey).

## Palette

| Neutral | Hex | Used for |
|---|---|---|
| crust | `#e3eaf1` | Quickshell bar, tmux status, tab bars |
| base | `#f4f7fa` | terminal, editor, file manager background |
| mantle | `#ebf0f5` | popups, cursor line |
| surface0 | `#dce4ec` | bar plates, buttons, inactive tabs |
| surface1 | `#cfd9e3` | hovered rows |
| surface2 | `#bccad8` | selected rows, borders, inactive window borders, ANSI bright white |
| overlay0 | `#91a1b3` | comments, float borders, ANSI white |
| overlay1 | `#718296` | disabled and hint text, bright black |
| subtext0 | `#536478` | secondary text |
| subtext1 | `#3d4c5e` | muted text, ANSI black |
| text | `#1f2a37` | main text |

| Accent | Hex | ANSI (normal / bright) |
|---|---|---|
| vader | `#c42f3a` | 1 / 9 (`#d94a53`) |
| tundra | `#3f8a3a` | 2 / 10 (`#4f9e48`) |
| beacon | `#a87b00` | 3 / 11 (`#c08f0a`) |
| saber | `#2f73c0` | 4 / 12 (`#4588d4`) |
| violet | `#7550b0` | 5 / 13 (`#8a66c4`) |
| glacier | `#1c7f86` | 6 / 14 (`#2a959c`) |
| rebel | `#d9581f` | accent |
| steel | `#546a82` | |
| frost | `#4a7fa8` | |
| hide | `#8a6a4e` | |

## Shapes, icons and words

- Medium corners (6 px), between the Empire's hard edges and the swamp's soft ones; the bar holds three ice-block plates.
- Frosted ice: kitty, the bar, popups and toasts are translucent over Hyprland's `prism` blur, which breaks the background into crystal facets. Neovim and Yazi leave the background unset so the ice shows through.
- Workspaces are ice crystals: an outlined diamond each, the active one filled in Rebel orange.
- Motion: windows glide in sideways on the wind, workspaces sweep like a blizzard, and the two-colour border turns round a newly focused window as if crossing sabers.
- kitty tabs and lualine sections are angled like ice shards; the kitty cursor leaves a short trail, like snow blown off a ridge.
- Labels on the bar and lock screen are uppercase, letter-spaced Oxanium, like Echo Base's hangar markings.
- Bar icons: mountains (wallpapers), Rebel crest (apps), heater (keep awake), alarm light (alerts), R2 unit (Bluetooth), AT-AT (power).
- Emblems: the crossed sabers of the duel above the lock screen, and a faint R2 unit or AT-AT in empty Bluetooth and alert lists.
- Popups: Comms (Wi-Fi), Droids, Sound, Glare (brightness), Alerts with Lie low (notifications), Generator with Low heat / Standard / Full power profiles, Evacuation (power) with a snowflake to shut down.
- Pickers: Echo Base (apps), the logs (clipboard), the snowfields (wallpapers), systems (themes).
- Lock screen: "Echo Base", "Clearance code", "Clearance refused".
- Fish greets you in an ice storm; Neovim opens on a HOTH banner.
- Theme picker: the themes appear as planets; this one is an ice planet with crevasses and a small moon.

## Fonts

- Monospace and icons: **MesloLGM Nerd Font** (`ttf-meslo-nerd`)
- Signage (clock, popup titles, lock screen): **Oxanium** (`ttf-oxanium`, AUR)
- Interface: system sans-serif

## Where each app gets it

| App | File |
|---|---|
| Quickshell | `quickshell/config/Theme.qml`, `quickshell/config/Icons.qml`, `quickshell/assets/icons/` (one-colour SVGs drawn by `components/SvgIcon.qml`), `quickshell/assets/planet.svg` (the theme in the theme picker) |
| Hyprland | `hypr/hyprland/appearance.lua`, `hypr/hyprland/rules.lua` (glass under Quickshell) |
| Kitty | `kitty/kitty.conf` (the 16 ANSI colours, inherited by eza, bat and other CLI tools) |
| Fish | `fish/conf.d/theme.fish`, `fish/functions/` |
| Tmux | `tmux/tmux.conf` |
| Yazi | `yazi/theme.toml` |
| Neovim | `nvim/lua/config/palette.lua`, `nvim/lua/plugins/colorscheme.lua` |
