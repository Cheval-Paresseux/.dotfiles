# Tatooine theme

A desert world on the Outer Rim: dusk-warm browns, sand-coloured text and
twin-sun accents. Shapes are rounded like adobe domes, the wording leans on
smugglers, droids and transmissions, and colour keeps one job per meaning.

Switch to it with `SUPER + T` or `~/.dotfiles/scripts/switch-theme.sh tatooine`.

## How colour is used

| Level | Colour | Meaning | Examples |
|---|---|---|---|
| Structure | browns | backgrounds, borders, secondary text | panels, separators, line numbers |
| Content | sand `#eedfc4` | what you are reading | file contents, titles, clock |
| Focus | sun `#f2a65a` | where you are, what is selected | active window border (sun → rust), active workspace, cursor, selected item, prompt directory, keywords |
| Info | sky `#7fb4b5` | neutral information | transmissions, connected droids, functions, directories |
| Success | sage `#a9b665` | good / added | charging, git additions, successful command, strings |
| Warning | gold `#f5cf73` | needs attention | battery under 30%, git changes, search matches, types, cantina mode |
| Critical | blaster `#e5533d` | error / destructive | errors, muted audio, battery under 15%, shut down |
| Other | rust, dusk, dusk blue, sand, bone | syntax highlighting and categories | numbers, regex, fields, parameters, media files |

## Palette

| Neutral | Hex | Used for |
|---|---|---|
| crust | `#130e0a` | Quickshell bar, tmux status, tab bars, text on accent |
| base | `#18120d` | terminal, editor, file manager background |
| mantle | `#1f1812` | popups, cursor line |
| surface0 | `#2b221a` | bar domes, buttons, ANSI black |
| surface1 | `#372b21` | hovered rows, inactive borders |
| surface2 | `#47382b` | selected rows, selection, borders |
| overlay0 | `#6e5b49` | comments, float borders, bright black |
| overlay1 | `#8c7663` | disabled and hint text |
| subtext0 | `#b9a58d` | secondary text |
| subtext1 | `#d3c1a5` | muted text, ANSI white |
| text | `#eedfc4` | main text, bright white |

| Accent | Hex | ANSI (normal / bright) |
|---|---|---|
| blaster | `#e5533d` | 1 / 9 (`#f0735e`) |
| sage | `#a9b665` | 2 / 10 (`#bcc97a`) |
| gold | `#f5cf73` | 3 / 11 (`#f8dc92`) |
| dusk blue | `#8aa6c1` | 4 / 12 (`#a0bdd6`) |
| dusk | `#b48ead` | 5 / 13 (`#c7a3c0`) |
| sky | `#7fb4b5` | 6 / 14 (`#98c8c8`) |
| sun | `#f2a65a` | accent |
| rust | `#d2734a` | |
| sand | `#dcbf8a` | |
| bone | `#c9b29b` | |

## Shapes, icons and words

- Rounded corners everywhere (windows, popups, pickers, Neovim floats); the bar is split into three rounded domes.
- Frosted glass: kitty, the bar, popups and toasts are translucent over a frost blur (Hyprland `blur.variant`), and the pickers frost the whole screen. Neovim and Yazi leave the background unset so the glass shows through.
- The kitty cursor leaves a short trail as it jumps (also in Neovim).
- Motion: windows rise from below with a soft spring, workspaces drift vertically, and the border gradient sweeps round a newly focused window.
- The lock screen blurs the wallpaper behind its signage.
- Labels in the bar and on the lock screen are uppercase and letter-spaced, like spaceport signage.
- Bar icons: twin sunset (wallpapers), Rebel insignia (apps), cantina glass (caffeine), antenna / uplink (transmissions), R2 unit (Bluetooth droids), Mandalorian helmet (power).
- Emblems: the Mandalorian helmet above the lock screen, and a faint TIE fighter or R2 unit in empty notification and Bluetooth lists.
- Popups: Comms (Wi-Fi), Droids (Bluetooth), Twin suns (brightness), Transmissions with Radio silence (notifications), Power cell with Conserve / Balanced / Boost profiles, a vault to lock and the Death Star to shut down.
- Lock screen: "Restricted area", "Access code", "Access denied".
- Fish greets you under twin suns; Neovim opens on a TATOOINE banner.
- Theme picker: the Star Wars themes appear as planets in their row; this one is a sand planet with dune seas under its twin suns.

## Fonts

- Monospace and icons: **MesloLGM Nerd Font** (`ttf-meslo-nerd`)
- Signage (clock, popup titles, lock screen): **Oxanium** (`ttf-oxanium`, AUR)
- Interface: system sans-serif

## Where each app gets it

| App | File |
|---|---|
| Quickshell | `quickshell/config/Theme.qml`, `quickshell/config/Icons.qml`, `quickshell/assets/icons/` (one-colour SVGs drawn by `components/SvgIcon.qml`), `quickshell/assets/emblem.svg` (the theme in the theme picker) |
| Hyprland | `hypr/hyprland/appearance.lua` |
| Kitty | `kitty/kitty.conf` (the 16 ANSI colours, inherited by eza, bat and other CLI tools) |
| Fish | `fish/conf.d/theme.fish`, `fish/functions/` |
| Tmux | `tmux/tmux.conf` |
| Yazi | `yazi/theme.toml` |
| Neovim | `nvim/lua/config/palette.lua`, `nvim/lua/plugins/colorscheme.lua` |
