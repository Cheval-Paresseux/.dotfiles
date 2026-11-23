# Mugen theme

Mugen's road, in *Characters*: a wandering swordsman with no master, no manners and
no hurry, where old Edo meets a hip-hop beat. A light theme of washi paper and sumi
ink, like the wallpapers: the vermilion of the rising sun marks whatever has your
attention, and the old dyes carry the rest: indigo for information, bamboo green
for success, ochre for warnings, crimson for danger. Nothing is glass here:
everything is printed, opaque, edged in ink and cut square.

Switch to it with `SUPER + T` or `~/.dotfiles/scripts/switch-theme.sh mugen`.

## How colour is used

| Level | Colour | Meaning | Examples |
|---|---|---|---|
| Structure | paper greys | backgrounds, borders, secondary text | panels, separators, line numbers |
| Content | sumi `#1e1a17` | what you are reading | file contents, titles, clock, the ink lines and shadows |
| Focus | sun `#d23a1e` | where you are, what is selected | active window border (sun → crimson), the workspace in the sun, the weekday's kanji, sword slashes, cursor, selected item, prompt directory, keywords |
| Info | indigo `#2e5a88` | neutral information | messengers (notifications), companions (Bluetooth), functions, commands |
| Success | bamboo `#4f7d35` | good / added | charging, git additions, successful command (the sword), strings |
| Warning | ochre `#a8740f` | needs attention | battery under 30%, git changes, search matches, types, the hot tea (keep awake) |
| Critical | crimson `#9c1730` | error / destructive | errors, failed command (the sword), muted audio, battery under 15%, shut down |
| Other | plum, celadon, steel, wood | syntax highlighting and categories | numbers, operators, fields, parameters |

It is a light theme, so the usual roles flip: text on the accent is white, and the
ANSI colours are dark enough to read on paper (ANSI "white" is a pale grey).

## Palette

| Neutral | Hex | Used for |
|---|---|---|
| crust | `#e9e3d7` | Quickshell bar, tmux status, tab bars |
| base | `#f5f1e8` | washi: terminal, editor, file manager background |
| mantle | `#efeae0` | popups, cursor line |
| surface0 | `#e3dccd` | buttons, inactive tabs |
| surface1 | `#d8cfbd` | hovered rows |
| surface2 | `#c6bca8` | selected rows, borders, inactive window borders, ANSI bright white |
| overlay0 | `#9c917f` | comments, ANSI white |
| overlay1 | `#7b7163` | disabled and hint text, bright black |
| subtext0 | `#5c544a` | secondary text |
| subtext1 | `#3f3932` | muted text, ANSI black |
| text | `#1e1a17` | sumi ink: main text, borders of popups, shadows |

| Accent | Hex | ANSI (normal / bright) |
|---|---|---|
| crimson | `#9c1730` | 1 / 9 (`#b8293f`) |
| bamboo | `#4f7d35` | 2 / 10 (`#62924a`) |
| ochre | `#a8740f` | 3 / 11 (`#c08a1e`) |
| indigo | `#2e5a88` | 4 / 12 (`#4573a3`) |
| plum | `#7a4588` | 5 / 13 (`#9160a0`) |
| celadon | `#23787a` | 6 / 14 (`#2f9092`) |
| sun | `#d23a1e` | accent |
| steel | `#5b6670` | fields, modules (Neovim) |
| wood | `#8a5634` | parameters (Neovim), archives |

## Shapes, icons and words

- Printed, not glass: no blur and no transparency. Windows have square corners and cast a hard ink shadow offset to the bottom right, like a woodblock print; popups and pickers are printed cards with an ink outline and the same shadow.
- The focused window wears the red cord: a border from the sun's vermilion to crimson. Motion is a sword fight with a beat: windows are drawn fast and overshoot, leave in one cut, workspaces slide past like a spin on the floor, and light runs along the border like a blade catching the sun.
- The bar is a strip of paper under a brush line of ink, its groups set apart by red sword slashes.
- Workspaces are written in the formal numerals of old documents and coins (壱 弐 参 肆 伍 陸 漆 捌 玖 拾), the current one in white inside the red sun.
- The clock leads with the weekday's kanji in red (日月火水木金土: sun, moon, fire, water, wood, gold, earth).
- Bar icons: the setting sun (wallpapers), the sword (apps), green tea (keep awake: hot while it is on), a messenger bird for notifications (a feather when there is nothing, asleep for Do Not Disturb), candle / low sun / high sun (brightness), a shoji door latched (lock).
- Popup titles open with a red kanji: 道 Roads (Wi-Fi) with On the road and Crossroads, 友 Companions (Bluetooth) with Travelling with and Strangers on the road, 音 Beats (audio) with Out loud and Listening, 日 Daylight (brightness), 文 Messengers (notifications) with Letters, 腹 Belly (battery) with its Pace: Nap / Stroll / Brawl, and 去 Leaving town (power).
- Pickers: "Pick a fight..." (apps, "Nothing worth drawing a sword for" when nothing matches), "What did you pocket?..." (clipboard), "Pick a scene..." (wallpapers), "Wander off somewhere else..." (themes).
- Lock screen: 無限 (mugen, "without limit") over a red sun holding the hour, the password written on a stroke of ink, and "Dozed off. Say the word and he gets up."
- Fish: a wanderer's hello that changes with the hour, the weekday in kanji, and how long you have been on the road (the uptime). The prompt ends in a sword, bamboo green after a success and crimson after a failure.
- Neovim opens on a red sun cut through by a sword stroke, above a letter-spaced MUGEN; lualine sections are cut on a slant. kitty tabs are slanted too, the current one in red; tmux windows are set apart by red slashes.
- Wallpapers: the three wanderers under the sun (the default), the standard-bearer, the snowboarding samurai.
- Theme picker: a katana drawn across the red sun, over a stroke of ink.

## Fonts

- Monospace and icons: **MesloLGM Nerd Font** (`ttf-meslo-nerd`)
- Kanji, popup titles, clock and lock screen: **Noto Sans CJK JP** in its heavy weights (`noto-fonts-cjk`)
- Interface: system sans-serif

## Where each app gets it

| App | File |
|---|---|
| Quickshell | `quickshell/config/Theme.qml`, `quickshell/config/Icons.qml`, `quickshell/assets/emblem.svg` (the theme in the theme picker), `modules/bar/WorkspaceList.qml` (the sun), `modules/bar/BarSlash.qml` (the sword slashes), `modules/bar/Clock.qml`, `components/PopupPanel.qml` (printed cards), `components/PopupHeader.qml` (kanji titles), `modules/lock/LockSurface.qml` |
| Hyprland | `hypr/hyprland/appearance.lua` |
| Kitty | `kitty/kitty.conf` (the 16 ANSI colours, inherited by eza, bat and other CLI tools) |
| Fish | `fish/conf.d/theme.fish`, `fish/functions/` |
| Tmux | `tmux/tmux.conf` |
| Yazi | `yazi/theme.toml` |
| Neovim | `nvim/lua/config/palette.lua`, `nvim/lua/plugins/colorscheme.lua`, `nvim/lua/plugins/snacks.lua` (dashboard), `nvim/lua/plugins/ui.lua` (lualine) |
