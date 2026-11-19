# Dagobah theme

A Jedi in exile on a swamp planet: misty greens, wet glass, and a blue saber
light for whatever has your attention, the colour Luke trains with in the
swamp. Shapes are soft and rounded, motion is patient, and the wording leans
on the light side: visions, meditation, patience and the swamp itself.

Switch to it with `SUPER + T` or `~/.config/dotfiles/scripts/switch-theme.sh dagobah`.

## How colour is used

| Level | Colour | Meaning | Examples |
|---|---|---|---|
| Structure | swamp greens | backgrounds, borders, secondary text | panels, separators, line numbers |
| Content | text `#dbe6dc` | what you are reading | file contents, titles, clock |
| Focus | saber `#6cb6ff` | where you are, what is selected | active window border (saber → mist), active workspace, cursor, selected item, prompt directory, keywords |
| Info | mist `#7cc4b8` | neutral information | visions, connected droids, functions, commands |
| Success | moss `#9ccc65` | good / added | charging, git additions, successful command, strings |
| Warning | lantern `#e8c15d` | needs attention | battery under 30%, git changes, search matches, types, lamp lit |
| Critical | ember `#e0735a` | error / destructive | errors, muted audio, battery under 15%, shut down |
| Other | lichen, water, bog, bark, reed | syntax highlighting and categories | numbers, fields, regex, operators, parameters, media files |

## Palette

| Neutral | Hex | Used for |
|---|---|---|
| crust | `#0a1110` | Quickshell bar, tmux status, tab bars, text on accent |
| base | `#0e1715` | terminal, editor, file manager background |
| mantle | `#131e1b` | popups, cursor line |
| surface0 | `#1a2824` | buttons, ANSI black |
| surface1 | `#22332e` | hovered rows, inactive borders |
| surface2 | `#2c403a` | selected rows, selection, borders |
| overlay0 | `#476058` | comments, float borders, bright black, idle workspaces |
| overlay1 | `#607a71` | disabled and hint text |
| subtext0 | `#90a79e` | secondary text |
| subtext1 | `#b4c6bd` | muted text, ANSI white |
| text | `#dbe6dc` | main text, bright white |

| Accent | Hex | ANSI (normal / bright) |
|---|---|---|
| ember | `#e0735a` | 1 / 9 (`#ec8d76`) |
| moss | `#9ccc65` | 2 / 10 (`#b2dc80`) |
| lantern | `#e8c15d` | 3 / 11 (`#f0d27f`) |
| saber | `#6cb6ff` | accent, 4 / 12 (`#8dc8ff`) |
| bog | `#a79bd6` | 5 / 13 (`#bcb2e3`) |
| mist | `#7cc4b8` | 6 / 14 (`#98d6cb`) |
| lichen | `#c8d67a` | |
| water | `#8fb3c9` | |
| bark | `#c2a27c` | |
| reed | `#cfd8b0` | |

## Shapes, icons and words

- Soft, rounded corners everywhere (windows, popups, pickers, Neovim floats). The bar floats above the bottom edge as one rounded branch.
- Wet glass: kitty, the bar, popups and toasts are translucent over Hyprland's `drops` blur, like rain on a window (the drops stand still, since animating them costs a lot of GPU). Neovim and Yazi leave the background unset so the glass shows through.
- Workspaces are fireflies: a small dot each, the active one stretched into a saber-blue glow.
- Motion: windows rise out of the mist on a soft spring, workspaces drift vertically, and the saber-to-mist border sweeps round a newly focused window.
- The kitty cursor leaves a trail like a drifting firefly (also in Neovim).
- Hand-drawn letters: Fantasque Sans Mono in the terminal, clock, popup titles and lock screen.
- Bar icons: pine tree (wallpapers), Jedi crest (apps), hut lamp (keep awake), lotus (visions), R2 unit (Bluetooth), Luke's saber hilt (power).
- Emblems: a glowing Jedi crest above the lock screen, and a faint R2 unit or X-wing in empty Bluetooth and notification lists.
- Popups: Comlink (Wi-Fi), Droids, Listen (audio), Visions with Meditate (notifications), Energy with Rest / Balance / Focus profiles, a candle to shut down.
- Pickers: "What do you seek?" (apps), memories (clipboard), the marsh (wallpapers).
- Lock screen: "Sanctuary", "Passphrase", "Listening to the Force...", "Passphrase rejected".
- Fish greets you with mist over the hut; Neovim opens on a DAGOBAH banner.
- Theme picker: the themes appear as planets; this one is a moss-green planet wrapped in mist.

## Fonts

- Terminal and signage: **FantasqueSansM Nerd Font** (`ttf-fantasque-nerd`)
- Icons: **MesloLGM Nerd Font** (`ttf-meslo-nerd`)
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
