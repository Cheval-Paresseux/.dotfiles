# CachyOS Fresh Install

## Overview

| Component | Choice |
|---|---|
| OS | CachyOS |
| Display Manager | SDDM (own login screens in `sddm/<name>/`: `star_wars`, `samurai`; the theme switcher picks the one of the theme's group) |
| Session Manager | UWSM |
| Desktop Environment | Hyprland |
| Bar, Notifications, Launcher | Quickshell |
| Lock Screen | Quickshell |
| Idle Daemon | Hypridle |
| Shell | Fish |
| Terminal | Kitty |
| File Manager | Yazi |
| File Editor | Neovim |
| Web Browser | Zen (not themed) |

Themes are grouped by universe. Star Wars, in `themes/star_wars/`: [`tatooine`](themes/star_wars/tatooine/README.md) (desert dusk), [`death_star`](themes/star_wars/death_star/README.md) (Imperial gunmetal and saber red), [`dagobah`](themes/star_wars/dagobah/README.md) (misty swamp and a blue saber), [`hoth`](themes/star_wars/hoth/README.md) (a light theme of snow and ice) and [`coruscant`](themes/star_wars/coruscant/README.md) (Art Deco onyx and champagne gold). Characters, in `themes/characters/`: [`eddie`](themes/characters/eddie/README.md) (a duke at home on his estate: tweed and oak, the scarlet of the hunting coat, saddle leather and brass), [`mugen`](themes/characters/mugen/README.md) (a light theme of washi paper, sumi ink and the red sun, where Edo meets hip-hop) and [`quinn`](themes/characters/quinn/README.md) (Harley Quinn, behind closed doors: black leather, neon magenta and the safeword lights). Switch with `SUPER + T` (one row per group: the Star Wars themes appear as planets, the Characters as objects from their scene) or `scripts/switch-theme.sh <theme>`: Hyprland, Quickshell, kitty, fish, Neovim and tmux reload in place, GTK apps switch to the theme's light or dark mode; Yazi follows on its next start.
[`themes/base`](themes/base/README.md) (neutral greys) is the template for new themes: it is not in the picker, but `scripts/switch-theme.sh base` still applies it.

# Installation

## 1. Prerequisites

Install CachyOS from the USB installer with **no desktop environment** and **no Firefox**, then update:

```bash
sudo pacman -Syu
```

The system side is left to the installer and to you; check it works before going further:

- graphics and other drivers,
- networking: `systemctl status NetworkManager` (`nmcli` is used by the bar),
- Bluetooth: `systemctl status bluetooth`,
- audio: `systemctl --user status pipewire pipewire-pulse wireplumber`, `wpctl status`,
- screen brightness: `brightnessctl -c backlight info` (the bar hides its brightness button without a backlight).

## 2. Desktop environment

```bash
git clone https://github.com/Cheval-Paresseux/.dotfiles.git ~/.dotfiles
~/.dotfiles/scripts/install.sh
sudo reboot
```

`scripts/install.sh` asks for `sudo` when needed and can be run again safely. It:

- installs the packages of the desktop (Hyprland, Quickshell, apps, fonts, development tools) from
  the repositories, and the Oxanium, Playfair and EB Garamond fonts from the AUR with `paru`; the list is at the top of the script,
- sets up Rust (`rustup default stable`, used by Neovim; language servers and formatters come from Mason),
- installs the login screens (Star Wars first) and makes SDDM the display manager (`scripts/install-sddm.sh`),
- makes fish the login shell,
- deletes the default configs of a fresh install (`~/.config/fish`, `hypr`, `kitty`, `nvim`, `quickshell`,
  `tmux`, `yazi`, when they are real directories) and links the `death_star` theme in their place.

It is meant for a fresh install: back up any of these directories you want to keep before running it.

After rebooting, log in to the **Hyprland (UWSM)** session.

## 3. Backing up Documents

Plug in a USB key (it appears in `/run/media/$USER/`), then run:

```bash
~/.dotfiles/scripts/backup-documents.sh
```

It copies everything in `~/Documents` except the `.git` directories and build output that can be rebuilt (`target/`, `node_modules/`) to a folder named after today's date
on the key (`YYYY-MM-DD/`), following symlinks. Running it again on the same day only copies what changed. With
several keys mounted, pass the one to use: `backup-documents.sh "/run/media/$USER/<label>"`.
