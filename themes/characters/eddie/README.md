# Eddie theme

Eddie's estate, in *Characters*: a duke at home on the land his family has held for
centuries, as much a farmer in muddy boots as a peer of the realm. The house is loden
and oak, its text the oatmeal of a good tweed. The scarlet of the hunting coat marks
whatever has your attention, and the overchecks of the tweed carry the rest: moss for
success, mustard for warnings, lovat blue for information, claret for danger. Saddlery
holds it together: leather stitched along its edges, set with brass rivets. Nothing is
glass here; everything is matte and opaque, like waxed cotton. Titles are set in Noto
Serif Display, like an estate's letterhead, and the family arms (a chevron between three
fleurs-de-lis, under a ducal coronet) turn up on the lock screen and in Neovim.

Switch to it with `SUPER + T` or `~/.dotfiles/scripts/switch-theme.sh eddie`.

## How colour is used

| Level | Colour | Meaning | Examples |
|---|---|---|---|
| Structure | loden and oak darks | backgrounds, borders, secondary text | panels, separators, line numbers |
| Content | oatmeal `#e8dfc5` | what you are reading | file contents, titles, clock |
| Focus | scarlet `#c8432c` | where you are, what is selected | active window border, the current workspace's shield, cursor, selected item, prompt directory, section titles, keywords, hovered bar icons, the lock screen's arms |
| Info | lovat `#7f9cb0` | neutral information | the post (notifications), hounds at heel (Bluetooth), functions, commands |
| Success | moss `#8ea35a` | good / added | charging, git additions, successful command (⚜), strings |
| Warning | mustard `#d0a443` | needs attention | battery under 30%, git changes, search matches, types, the kettle on the boil (keep awake) |
| Critical | claret `#a63a55` | error / destructive | errors, failed command (⚜), muted audio, battery under 15%, shut down |
| Other | heather, lichen, saddle, leather, brass | syntax highlighting and saddlery | numbers, operators, parameters, stitching, rivets, git branch |

Scarlet and claret are both reds, so they are kept apart: scarlet is warm and bright and
only ever means focus, claret is deeper and cooler and only ever means danger (ANSI red is
claret). Text on scarlet and claret is cream; on the lighter tweeds it is dark.

## Palette

| Neutral | Hex | Used for |
|---|---|---|
| crust | `#100f0b` | Quickshell bar, tmux status |
| base | `#15130e` | terminal, editor and file manager background, kitty tab bar |
| mantle | `#1b1913` | popups, pickers, cursor line |
| surface0 | `#23201a` | buttons, ANSI black |
| surface1 | `#2d2921` | hovered rows, inactive borders |
| surface2 | `#3a352a` | selected rows, selection, borders, section rules |
| overlay0 | `#554e3f` | autosuggestions, bright black, empty workspace shields |
| overlay1 | `#776e5a` | comments, disabled and hint text |
| subtext0 | `#a39a80` | secondary text, the date |
| subtext1 | `#c7bea2` | muted text, ANSI white |
| text | `#e8dfc5` | oatmeal: main text, bright white |

| Accent | Hex | ANSI (normal / bright) |
|---|---|---|
| claret | `#a63a55` | 1 / 9 (`#c25a72`) |
| moss | `#8ea35a` | 2 / 10 (`#a8bc76`) |
| mustard | `#d0a443` | 3 / 11 (`#e2bf6c`) |
| lovat | `#7f9cb0` | 4 / 12 (`#9db6c7`) |
| heather | `#9b85ad` | 5 / 13 (`#b6a2c6`) |
| lichen | `#6e9f92` | 6 / 14 (`#8dbaad`) |
| scarlet | `#c8432c` | accent |
| saddle | `#b5865a` | parameters (Neovim), git branch, images (Yazi), reboot |
| leather | `#8c6a45` | stitching, ornaments, float borders |
| brass | `#c2a05a` | rivets, the slider's handle, the edge of the arms |

## Shapes, icons and words

- Matte, not glass: no blur and no transparency. Corners are barely rounded (4 px); windows rest on a soft, heavy shadow, the focused one edged in the scarlet of a hunting coat, a shade deeper in the folds.
- Saddlery: the bar is a leather strap, stitched along its edges, its sections set apart by brass rivets. Popups and pickers are stitched the same way, and the slider's handle is a rivet.
- Workspaces are small heraldic shields numbered in Roman figures (I, II, III…), the current one emblazoned in scarlet.
- The clock is dated like a letterhead: the day in serif italics, the hour in serif figures.
- Motion is a steady canter: windows come in at an even pace and settle without fuss, leave with a nod, and workspaces ride past like the next field over the hedge.
- The gramophone in the drawing room: what is playing (any MPRIS player) is shown in italics next to a turning record. Click to pause or play, scroll to change track.
- Bar icons: a frame from the gallery (wallpapers), the butler's bell (apps), the kettle (keep awake: on the boil while it is on), a sealed letter for the post (opened when there is nothing new, the estate gates for Do Not Disturb), overcast / bright spells / the rare sunny day (brightness), the door out (power).
- Popups: The telegraph (Wi-Fi) with On the wire and Lines in the county, The kennel (Bluetooth) with At heel and Strays, The wireless (audio), The weather (brightness), The post (notifications) with Letters, The stables (battery) with its pace, Walk / Trot / Gallop, and Calling it a day (power) with Taking leave.
- Pickers: "Ring for anything..." (apps, "Nothing of the sort on the estate" when nothing matches), the estate books (clipboard), the gallery (wallpapers), other houses (themes).
- Empty lists show a faint object from the estate: an empty letterbox, a hound, a sprig of barley.
- Lock screen: the family arms in scarlet edged in brass, PRIVATE ESTATE, a large serif clock, the date in italics, and "The gates are shut. State your business."
- Fish: good day from the estate according to the hour, addressed to Your Grace, and how long you have been out in the fields (the uptime). The prompt ends in a fleur-de-lis, moss after a success and claret after a failure.
- Neovim opens on the family arms under a ducal coronet, above a letter-spaced EDDIE; lualine sections have rounded ends like the leather tabs of a ledger. kitty and tmux tabs are set apart by fleurs-de-lis, the current one in scarlet.
- Wallpapers: the three images from the lounge are still in place (a glass and a cigar, a record, a guest in an armchair); country-estate images would suit the theme better (see below).
- Theme picker: the Characters themes appear as objects from their scene, in a row of their own; this one is a flat cap in heather tweed with a scarlet overcheck.

## Fonts

- Monospace and icons: **MesloLGM Nerd Font** (`ttf-meslo-nerd`)
- Clock, popup titles, workspace numerals, italics and lock screen: **Noto Serif Display** (`noto-fonts`)
- Interface: system sans-serif

## Wallpapers that would fit

The palette was drawn from the estate itself rather than from the current wallpapers. Images
in the same mood: a country house or its gun room, misty fields and hedgerows, a shooting
party or a hunt, tweed, oak panelling, horses and hounds, ideally dark and muted with a touch
of red. Put them in `quickshell/assets/wallpapers/` and set `defaultWallpaper` in
`quickshell/config/Theme.qml`.

## Where each app gets it

| App | File |
|---|---|
| Quickshell | `quickshell/config/Theme.qml`, `quickshell/config/Icons.qml`, `quickshell/assets/emblem.svg` (the theme in the theme picker), `components/Stitching.qml` (the saddle stitching), `modules/bar/BarDivider.qml` (the rivets), `modules/bar/WorkspaceList.qml` (the shields), `modules/bar/NowPlaying.qml` (the gramophone), `components/EmptyState.qml` (empty lists), `modules/lock/LockSurface.qml` (the arms) |
| Hyprland | `hypr/hyprland/appearance.lua` |
| Kitty | `kitty/kitty.conf` (the 16 ANSI colours, inherited by eza, bat and other CLI tools) |
| Fish | `fish/conf.d/theme.fish`, `fish/functions/` |
| Tmux | `tmux/tmux.conf` |
| Yazi | `yazi/theme.toml` |
| Neovim | `nvim/lua/config/palette.lua`, `nvim/lua/plugins/colorscheme.lua`, `nvim/lua/plugins/snacks.lua` (dashboard), `nvim/lua/plugins/ui.lua` (lualine) |
