# Death Star theme

The Empire's battle station: gunmetal hull plating, a single saber red for
whatever has your attention, and Force-lightning violet for anything that
destroys. Shapes are hard and angular, cut like the trapezoid viewports of
the bridge, motion is heavy and abrupt, and the wording speaks in Imperial
command and security.

Switch to it with `SUPER + T` or `~/.dotfiles/scripts/switch-theme.sh death_star`.

## How colour is used

| Level | Colour | Meaning | Examples |
|---|---|---|---|
| Structure | gunmetal greys | backgrounds, borders, secondary text | panels, plates, separators, line numbers |
| Content | text `#dfe2e6` | what you are reading | file contents, titles, clock |
| Focus | saber `#e32b36` | where you are, what is selected | active window border and glow, active workspace, cursor, selected item, prompt directory, keywords |
| Info | imperial blue `#73a7d9` | neutral information | dispatches, connected droids, functions, directories |
| Success | reactor green `#84c26a` | good / added | charging, git additions, successful command, strings |
| Warning | alarm amber `#f2b134` | needs attention | battery under 30%, git changes, search matches, types, sentry mode |
| Critical | lightning `#b18cff` | error / destructive | errors, git deletions, muted audio, battery under 15%, shut down |
| Other | blood, fire, hologram, steel | syntax highlighting and categories | the hull seam and window border fade, numbers, regex, fields, media files |

Saber red is the focus colour, so destructive actions get their own colour: the
violet of Force lightning. The terminal's ANSI red stays red (`color1` is
saber red), because command-line tools use it for errors and deletions.

## Palette

| Neutral | Hex | Used for |
|---|---|---|
| crust | `#08090b` | Quickshell bar, tmux status, tab bars, text on accent |
| base | `#0d0f12` | terminal, editor, file manager background |
| mantle | `#131519` | popups, cursor line |
| surface0 | `#1b1e23` | bar plates, buttons, ANSI black |
| surface1 | `#24282e` | hovered rows, inactive borders |
| surface2 | `#30353d` | selected rows, selection, borders |
| overlay0 | `#4b515b` | comments, bright black |
| overlay1 | `#676e79` | disabled and hint text |
| subtext0 | `#9399a3` | secondary text |
| subtext1 | `#b8bdc5` | muted text, ANSI white |
| text | `#dfe2e6` | main text, bright white |

| Accent | Hex | ANSI (normal / bright) |
|---|---|---|
| saber | `#e32b36` | accent, 1 / 9 (`#f04d57`) |
| reactor | `#84c26a` | 2 / 10 (`#9dd685`) |
| alarm | `#f2b134` | 3 / 11 (`#f6c55e`) |
| imperial blue | `#73a7d9` | 4 / 12 (`#92bde6`) |
| lightning | `#b18cff` | 5 / 13 (`#c6a9ff`) |
| hologram | `#6fc3c9` | 6 / 14 (`#8fd6db`) |
| blood | `#8f1820` | |
| fire | `#e8743b` | |
| steel | `#9aa8b8` | |

## Shapes, icons and words

- No rounded corners anywhere. The bar is a crust strip with a blood-red hull seam on top, carrying three trapezoid plates shaped like the bridge viewports; kitty tabs and lualine sections repeat the slant.
- Opaque, solid panels (no glass). Inactive windows are dimmed into shadow; the focused one has a saber-to-blood gradient border and a red glow.
- Motion: windows slam in with a short overshoot, workspaces slide like blast doors, and nothing fades slowly.
- The kitty cursor leaves a short trail as it moves, like a saber swing (also in Neovim).
- Labels on the bar and lock screen are uppercase, letter-spaced Oxanium, like stencilled hull markings.
- Bar icons: the Death Star (wallpapers), Imperial crest (apps), sentry eye (caffeine), uplink / broadcast (dispatches), industrial droid (Bluetooth), Vader's helmet (power).
- Emblems: a glowing Vader helmet above the lock screen, and a faint AT-AT or TIE fighter in empty Bluetooth and notification lists.
- Popups: Holonet (Wi-Fi), Droids, Intercom (audio), Floodlights (brightness), Dispatches with Silent running (notifications), Reactor with Reserve / Standard / Overdrive profiles, Command (power) with the Sith emblem for shut down.
- Pickers: the armory (apps), intercepted data (clipboard), surveillance feeds (wallpapers), sectors (themes).
- Lock screen: "Imperial security", "Authorization code", "Clearance denied".
- Fish greets you as a Sith lord with the reactor online; Neovim opens on a DEATH STAR banner.
- Theme picker: the themes appear as planets; this one is the battle station, its dish lit red.

## Fonts

- Monospace and icons: **MesloLGM Nerd Font** (`ttf-meslo-nerd`)
- Signage (clock, workspaces, popup titles, lock screen): **Oxanium** (`ttf-oxanium`, AUR)
- Interface: system sans-serif

## Where each app gets it

| App | File |
|---|---|
| Quickshell | `quickshell/config/Theme.qml`, `quickshell/config/Icons.qml`, `quickshell/assets/icons/` (one-colour SVGs drawn by `components/SvgIcon.qml`), `quickshell/assets/planet.svg` (the theme in the theme picker), `modules/bar/BarGroup.qml` (the trapezoid plates) |
| Hyprland | `hypr/hyprland/appearance.lua` |
| Kitty | `kitty/kitty.conf` (the 16 ANSI colours, inherited by eza, bat and other CLI tools) |
| Fish | `fish/conf.d/theme.fish`, `fish/functions/` |
| Tmux | `tmux/tmux.conf` |
| Yazi | `yazi/theme.toml` |
| Neovim | `nvim/lua/config/palette.lua`, `nvim/lua/plugins/colorscheme.lua` |
