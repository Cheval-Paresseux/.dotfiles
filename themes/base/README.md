# Base theme

Simple and square. Neutral greys build the structure, and a small set of vivid
green, blue and yellow accents marks what matters. Each colour has one job, so the
same colour means the same thing in every app.

## How colour is used

| Level | Colour | Meaning | Examples |
|---|---|---|---|
| Structure | greys | backgrounds, borders, secondary text | panels, separators, line numbers |
| Content | text `#e6e6e6` | what you are reading | file contents, titles, clock |
| Focus | aqua `#73daca` | where you are, what is selected | active window border, active workspace, cursor, selected item, prompt directory, section titles, keywords |
| Info | blue `#7aa2f7` | neutral information | notifications, connected Bluetooth, links, functions, directories |
| Success | green `#9ece6a` | good / added | charging, git additions, successful command, strings |
| Warning | yellow `#ecd06f` | needs attention | battery under 30%, git changes, search matches, types |
| Critical | red `#f7768e` | error / destructive | errors, muted audio, battery under 15%, shut down |
| Other | orange, sky, light blue, sand, magenta | syntax highlighting and categories | numbers, operators, fields, parameters, media files |

## Palette

| Neutral | Hex | Used for |
|---|---|---|
| crust | `#111111` | Quickshell bar, tmux status, tab bars, text on accent |
| base | `#161616` | terminal, editor, file manager background |
| mantle | `#1c1c1c` | popups, cursor line |
| surface0 | `#262626` | buttons, ANSI black |
| surface1 | `#303030` | hovered rows, inactive borders |
| surface2 | `#3d3d3d` | selected rows, selection, borders |
| overlay0 | `#595959` | comments, float borders, bright black |
| overlay1 | `#737373` | disabled and hint text |
| subtext0 | `#a6a6a6` | secondary text |
| subtext1 | `#c4c4c4` | muted text, ANSI white |
| text | `#e6e6e6` | main text, bright white |

| Accent | Hex | ANSI (normal / bright) |
|---|---|---|
| red | `#f7768e` | 1 / 9 (`#ff8ba0`) |
| green | `#9ece6a` | 2 / 10 (`#b3e07f`) |
| yellow | `#ecd06f` | 3 / 11 (`#f5de8a`) |
| blue | `#7aa2f7` | 4 / 12 (`#94b6ff`) |
| magenta | `#bb9af7` | 5 / 13 (`#cbb0ff`) |
| aqua | `#73daca` | 6 / 14 (`#8eeedb`), accent |
| sky | `#7dcfff` | |
| light blue | `#a6c8ff` | |
| orange | `#ff9e64` | |
| sand | `#e0c08c` | |
| mist | `#b8c4d6` | |

## Fonts

- Monospace and icons: **MesloLGM Nerd Font** (`ttf-meslo-nerd`)
- Interface: system sans-serif

## Where each app gets it

| App | File |
|---|---|
| Quickshell | `quickshell/config/Theme.qml`, `quickshell/assets/emblem.svg` (the theme in the theme picker) |
| Hyprland | `hypr/hyprland/appearance.lua` |
| Kitty | `kitty/kitty.conf` (the 16 ANSI colours, inherited by eza, bat and other CLI tools) |
| Fish | `fish/conf.d/theme.fish`, `fish/functions/fish_prompt.fish` |
| Tmux | `tmux/tmux.conf` |
| Yazi | `yazi/theme.toml` |
| Neovim | `nvim/lua/config/palette.lua`, `nvim/lua/plugins/colorscheme.lua` |
