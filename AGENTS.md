# AGENTS.md

Personal desktop dotfiles (CachyOS + Hyprland). Every theme is a complete, self-contained
set of configs; `scripts/switch-theme.sh` links one into `~/.config` and reloads the session.

## Layout

```
themes/<theme>/            a theme, directly in themes/ or in a group (themes/star_wars/<theme>)
  fish/        conf.d/theme.fish (colours), conf.d/theme-reload.fish, functions/ (prompt, greeting)
  hypr/        Hyprland Lua config (hyprland.lua, hyprland/*.lua)
  kitty/       kitty.conf: the 16 ANSI colours every CLI tool inherits
  nvim/        lazy.nvim config, palette in lua/config/palette.lua
  quickshell/  bar, popups, pickers, lock, wallpaper; palette in config/Theme.qml, glyphs in config/Icons.qml
               (a theme may add one-colour SVGs in assets/icons, drawn and tinted by components/SvgIcon.qml);
               assets/emblem.svg is the full-colour picture that stands for the theme in the theme picker
  tmux/        tmux.conf
  yazi/        theme.toml
  README.md    palette, colour rules, shapes/icons, file map
scripts/switch-theme.sh   <theme> | --list
scripts/install.sh        packages, services, login shell, then the death_star theme
scripts/install-sddm.sh   copies sddm/ to /usr/share/sddm/themes/dotfiles and enables SDDM
sddm/                     SDDM login screen (one for all themes: it runs before any session), live wallpapers
```

`switch-theme.sh` reloads the running session: Hyprland, Quickshell (restart), kitty and
Neovim (SIGUSR1), fish (the `dotfiles_theme` universal variable), tmux, and GTK's light/dark mode
(`hyprland.lua` sets it on `config.reloaded`). Any new config
that can reload live should hook into the same mechanism, in every theme. It also links each
theme's `fish/fish_variables` (ignored by the root `.gitignore`) to `~/.local/state/fish/fish_variables`, so fish
universal variables are shared by all themes.

Themes are named by their directory (`hoth`, not `star_wars/hoth`), so names must be unique across groups.
A group holds up to five themes: the theme picker shows one row per group, its emblems drawn in the
group's style (Star Wars: planets; Characters: objects from the scene).
`themes/base` is the reference: simple, square, neutral greys with vivid accents. It is a template for new
themes, not offered in the theme picker (`switch-theme.sh base` still works for testing).
Every theme ships the same app directories (the switcher refuses a theme with one missing).

## General rules

- **Don't commit** unless asked. Leave changes in the working tree and say what changed.
- **Keep code comprehensible**: no wrappers or abstractions that don't pay for themselves,
  no dead code, few comments (only the non-obvious *why*). Only set options that differ from defaults.
- **Share instead of duplicating** inside a theme (e.g. `PickerGrid` serves the wallpaper and theme pickers).
- **Never touch the user's live setup without a reason**; when you must (screenshots, live
  tests), restore it afterwards and say so. Personal state (saved wallpaper, settings)
  lives in `~/.local/state/quickshell/…/settings-<theme>.json` and must survive changes.
- Keep private information (email, etc.) out of files and external requests.
- Update the READMEs when behaviour, keybinds or palette change.
- Changes outside the theme's look (keybinds, reload hooks, shared components, bug fixes)
  go into **every** theme, not only the one being worked on.

## Colour principles

Each colour has one job, and the same colour means the same thing in every app:

| Role | Meaning |
|---|---|
| neutrals (crust → text) | structure: backgrounds, borders, secondary text |
| text | content being read |
| accent | focus: where you are, what is selected, active border, prompt directory |
| info | neutral information (notifications, connected devices, functions) |
| success | good / added (charging, git additions, strings) |
| warning | needs attention (low battery, git changes, types) |
| critical | errors and destructive actions (muted, very low battery, shut down) |
| other accents | syntax highlighting and categories only |

Keep the overall look mostly neutral; vivid colour is reserved for what matters.
Define the palette once per app (`Theme.qml`, `palette.lua`, `theme.fish`, …) and reference
role names, not raw hex, wherever the app allows it.

## Workflow: creating a new theme

1. **Copy the base theme** as the starting point: `cp -r themes/base themes/<name>` (or `themes/<group>/<name>`), then
   replace the wallpapers in `quickshell/assets/wallpapers/` and set `name` and
   `defaultWallpaper` in `quickshell/config/Theme.qml` (the default must be a file that exists).
   Draw the theme's own `quickshell/assets/emblem.svg` (200×200, lit from the top left, in the theme's
   palette) in its group's style so it can be told apart in the theme picker: a planet of radius 70 at
   the centre for Star Wars, an object from the theme's scene for Characters (eddie: a snifter).

2. **Adapt every component with what is already installed.** Go beyond recolouring:
   - *Palette*: derive it from the wallpapers; keep the role mapping above. Update every app:
     Quickshell, Hyprland borders/shadows, kitty ANSI colours, fish, tmux, yazi, Neovim
     (`palette.lua` + `colorscheme.lua` + lualine).
   - *Shapes*: radius, gaps, borders (gradients are allowed), bar layout, separators, tab styles.
   - *Icons*: pick Nerd Font glyphs that tell the theme's story (look them up by name in the
     installed font; insert BMP private-use glyphs U+E000–F8FF via Python `chr()`, since
     heredocs/editors may silently drop them).
   - *Words*: themed titles, placeholders, empty states, greeting and dashboard banner; keep
     action labels plain ("Shut down", "Lock") so they stay unambiguous. Write original text,
     not quotes from copyrighted works.
   - Write the theme's `README.md` (palette tables, colour rules, shapes/icons/words, file map)
     and list the theme in the root README.

3. **Propose packages, don't install them.** If a font, tool or package would clearly
   improve the design (a display font, a different Nerd Font, a helper tool), suggest it
   with the reason and what it would change. Only use it once the user has installed it
   and confirmed the exact name (e.g. from `fc-list : family`); then add it to `scripts/install.sh`.

4. **Review the code** before reporting:
   - Remove leftovers from the base copy (unused colours/properties, stale comments mentioning base).
   - grep for references to anything renamed or removed (e.g. `Theme.<old>`, `p.<old>` in nvim).
   - Validate each app (below), look at screenshots, and fix what is off.
   - Report what was done, what could not be tested, and any bugs found along the way.

## Validation

| App | Check |
|---|---|
| Quickshell | run the theme's copy: `qs -p themes/<t>/quickshell -d`, open popups via `qs -p … ipc call <target> toggle`, read `qs -p … log` for QML errors; restore the live shell with `qs kill; qs -d` |
| Hyprland | `Hyprland --verify-config --config themes/<t>/hypr/hyprland.lua`; for the live config `hyprctl reload && hyprctl configerrors` |
| Neovim | start with `XDG_CONFIG_HOME` pointing at a dir whose `nvim` links to the theme; check highlights, LSP clients and plugins load; format with `stylua` (`stylua --check .`; it is in `~/.local/share/nvim/mason/bin`, not on PATH) |
| fish | `fish -n` on every file |
| kitty | `kitty +runpy` with `kitty.config.load_config(<path>)` |
| yazi | `YAZI_CONFIG_HOME=themes/<t>/yazi yazi` starts without errors |
| tmux | `tmux -L check -f themes/<t>/tmux/tmux.conf new-session -d`, then `tmux -L check kill-server` |
| SDDM | `sddm-greeter-qt6 --test-mode --theme sddm` opens it in a window; kill it by PID afterwards |
| Switcher | `scripts/switch-theme.sh --list`; a live switch to the theme and back |
| Visuals | screenshots with `grim` (window geometry from `hyprctl clients -j`) |

Not installed here: ImageMagick/PIL (use ffmpeg for image work), node. Say when something
could not be tested rather than assuming it works.

## Pitfalls met so far

- Nerd Font glyphs in the BMP private-use area get dropped by heredocs/editors: write them with Python `chr()`.
- kitty does not allow comments at the end of a line; a reloaded option only applies live if
  kitty supports it (`background_opacity` needs `dynamic_background_opacity yes` at startup).
- Third-party SVGs copied into a theme's `quickshell/assets/icons/` are prepared for tinting: credit text and
  off-canvas template shapes removed, viewBox cropped to the drawing, fills set to white. Their creators are
  credited in the root README (Credits); check them rendered at bar size (`rsvg-convert -w 16`) before use.
- Qt renders SVGs as SVG Tiny: `clip-path` and masks are ignored, so keep every shape inside its outline.
  Quickshell caches images by URL, so an edited SVG only shows after a `qs kill; qs -d`.
- Hyprland layer rules match the Quickshell `WlrLayershell.namespace`; keep namespaces unique.
- A light theme flips a few defaults: text on the accent is white, ANSI colours are darkened
  to read on the background (ANSI "white" becomes a pale grey), and Neovim needs
  `vim.o.background = "light"`.
- `pkill -f <pattern>` can match the shell running it; kill by PID from `hyprctl clients -j` or `pgrep`.
- SDDM: a comma-separated `theme.conf` value arrives as a list (use `String(config.x)`); Qt Multimedia does not
  resolve relative paths like `Image` does (use `Qt.resolvedUrl`).
- A test instance (`qs -p …`) can take over the IPC lookup of the live shell: every `qs ipc call` keybind
  (Super+T, lock, power) then fails. After testing, kill the live `qs` by PID, start it with `qs -d`, and check `qs ipc show`.
- `Hyprland --verify-config` runs the config's `config.reloaded` handlers, so it changes the live GTK settings
  (`gsettings`): verify the live theme last, or restore it afterwards.
- Hyprland option names and defaults: `hyprctl descriptions -j`; Lua API stubs: `/usr/share/hypr/stubs/hl.meta.lua`.
