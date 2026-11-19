# Coruscant theme

The city that covers a whole planet and runs the galaxy, seen from its most
exclusive floors, where the markets are watched from a private bank's trading
desk: onyx navy, polished champagne gold for whatever has your attention, ivory
text, and jewel tones for the rest. Emerald and ruby keep the market's meaning,
good news and bad, and quotes, sparklines and index lines run through the theme. Shapes follow Art Deco: fine gold hairlines,
double rules, cut corners and ◆ ornaments. Glass is tinted champagne, motion is
slow and smooth, and headlines are set in fine, widely spaced capitals. The wording
belongs to the Exchange and the Senate.

Switch to it with `SUPER + T` or `~/.dotfiles/scripts/switch-theme.sh coruscant`.

## How colour is used

| Level | Colour | Meaning | Examples |
|---|---|---|---|
| Structure | onyx navy greys | backgrounds, borders, secondary text | panels, separators, line numbers |
| Content | ivory `#ece6d8` | what you are reading | file contents, titles, clock |
| Focus | gold `#d8b26e` | where you are, what is selected | active window border and halo, active workspace, cursor, selected item, prompt directory, keywords, the bar's hairline, dividers and quote symbols, hovered bar icons |
| Info | sapphire `#7ea6e0` | neutral information | bulletins, connected droids, functions, commands |
| Success | emerald `#4fb38a` | good / added | charging, git additions, successful command (▲), strings |
| Warning | topaz `#e39a55` | needs attention | battery under 30%, CPU or memory over 75%, git changes, search matches, types, working late |
| Critical | ruby `#d9506a` | error / destructive | errors, failed command (▼), muted audio, battery under 15%, load over 90%, shut down |
| Other | amethyst, aquamarine, steel, champagne, brass | syntax highlighting and categories | numbers, regex, fields, float borders, the metallic gold gradients |

Emerald and ruby keep their market meaning: the prompt shows ▲ in emerald after a
success and ▼ in ruby after a failure. The bar's ticker arrows stay neutral,
since a rising load is not good news; only a high load is coloured.

## Palette

| Neutral | Hex | Used for |
|---|---|---|
| crust | `#07080c` | Quickshell bar, tmux status, text on accent |
| base | `#0b0d13` | terminal background, kitty tab bar |
| mantle | `#10131b` | popups, cursor line |
| surface0 | `#161a24` | buttons, input fields, ANSI black |
| surface1 | `#1e2330` | hovered rows, inactive borders |
| surface2 | `#2a3040` | selected rows, selection, borders |
| overlay0 | `#474d5e` | comments, bright black |
| overlay1 | `#656b7c` | disabled and hint text |
| subtext0 | `#a8a49b` | secondary text, ticker |
| subtext1 | `#cdc8bc` | muted text, ANSI white |
| text | `#ece6d8` | ivory: main text, bright white |

| Accent | Hex | ANSI (normal / bright) |
|---|---|---|
| ruby | `#d9506a` | 1 / 9 (`#e57489`) |
| emerald | `#4fb38a` | 2 / 10 (`#72c9a3`) |
| gold | `#d8b26e` | accent, 3 / 11 (champagne `#f0d9a0`) |
| sapphire | `#7ea6e0` | 4 / 12 (`#a3c2ec`) |
| amethyst | `#a68bd8` | 5 / 13 (`#bea9e6`) |
| aquamarine | `#6fbfb8` | 6 / 14 (`#93d3cd`) |
| topaz | `#e39a55` | |
| steel | `#9aa6bf` | |
| champagne | `#f0d9a0` | the light end of the gold gradients |
| brass | `#8c6a32` | the dark end of the gold gradients, float borders |

## Shapes, icons and words

- The bar is one strip of polished onyx under a gold hairline that fades out at both ends. Sections are set apart by thin gold rules rather than boxes; icons are warm grey and turn gold under the pointer.
- The clock is the bar's centrepiece, set like a watch dial between two ◆: the time in large figures, the date in small capitals below, on Galactic Standard Time.
- The bar's market board quotes CPU and memory use like shares, each with a gold sparkline of the last ninety seconds and its latest move (▲ ▼ ▪), then the network's incoming traffic: `CPU ╱╲ 12% ▲ ◆ MEM ── 41% ▪ ◆ NET ↓ 1.2 MB/s`.
- Art Deco lines: ◆ ornaments and fine gold rules recur everywhere.
- Polished gold: the focused window has a champagne-to-brass border and a soft gold halo; the active workspace and the lock screen's emblem are gilded.
- Champagne glass: kitty, the bar, popups and toasts are translucent over Hyprland's `acrylic` blur, tinted faintly gold. Neovim and Yazi leave the background unset so the glass shows through.
- Motion: velvet lifts. Windows rise and settle without a jolt, workspaces glide between floors with a fade, and panels fade in like lights coming up in a lobby.
- Workspaces are a volume chart of gold-outlined columns: each grows with the windows it holds, and the active one is filled with polished gold.
- Headlines are letter-spaced Noto Sans Display capitals, like a private bank's letterhead: the clock, the market board, popup titles and the lock screen.
- Lock screen: the gilded portico of the exchange, "Coruscant Exchange" between engraved gold hairlines, a large light-weight clock, "Trading suspended" and a field for your trader credentials.
- kitty tabs are quiet labels set apart by gold ◆, the active one in gold capitals; lualine sections end in pixel blocks like an LED ticker board.
- Bar icons: city (wallpapers), bank (apps), briefcase with a clock (keep awake: working late), newspaper (bulletins), robot (Bluetooth), gavel (power).
- Emblems: a faint protocol droid or skyline in empty Bluetooth and notification lists.
- Popups: Holonet with its relays (Wi-Fi), Droids, Public address (audio), Holonews with Closed session (notifications), Treasury with Austerity / Stable / Growth profiles, Session (power) with a gavel to shut down.
- Pickers: the directory (apps), the ledger (clipboard), districts (wallpapers), systems (themes).
- Fish greets you like a concierge ("Good evening, Senator …. The Exchange awaits you") and quotes the day's load index, the system load with its move against the last fifteen minutes. Neovim opens on an engraved, letter-spaced CORUSCANT under a small rising bar chart, between gold rules.
- Wallpapers drawn for the theme: an Art Deco panel of gold fans with the exchange tower in a gilded arch, a ticker tape across the top and an index line climbing behind (the default), the skyline at dusk, the Galactic Core Index on the exchange boards, and the Senate chamber seen from a delegation pod.
- Theme picker: the themes appear as planets; this one is a city-world, its night side covered in gold lights.

## Fonts

- Monospace and icons: **MesloLGM Nerd Font** (`ttf-meslo-nerd`)
- Headlines (clock, market board, workspaces, bar labels, popup titles, lock screen): **Noto Sans Display** (`noto-fonts`)
- Interface: system sans-serif

## Where each app gets it

| App | File |
|---|---|
| Quickshell | `quickshell/config/Theme.qml`, `quickshell/config/Icons.qml`, `quickshell/assets/icons/` (one-colour SVGs drawn by `components/SvgIcon.qml`), `quickshell/assets/planet.svg` (the theme in the theme picker), `modules/bar/BarDivider.qml` (the gold rules between sections), `modules/bar/MarketTicker.qml` (the market board) |
| Hyprland | `hypr/hyprland/appearance.lua`, `hypr/hyprland/rules.lua` (glass under Quickshell) |
| Kitty | `kitty/kitty.conf` (the 16 ANSI colours, inherited by eza, bat and other CLI tools) |
| Fish | `fish/conf.d/theme.fish`, `fish/functions/` |
| Tmux | `tmux/tmux.conf` |
| Yazi | `yazi/theme.toml` |
| Neovim | `nvim/lua/config/palette.lua`, `nvim/lua/plugins/colorscheme.lua` |
