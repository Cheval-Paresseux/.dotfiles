# CachyOS Fresh Install

## Overview

| Component | Choice |
|---|---|
| OS | CachyOS |
| Display Manager | Ly |
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

Themes live in `themes/`: [`base`](themes/base/README.md) (neutral greys), [`tatooine`](themes/tatooine/README.md) (desert dusk), [`death_star`](themes/death_star/README.md) (Imperial gunmetal and saber red), [`dagobah`](themes/dagobah/README.md) (misty swamp and a blue saber), [`hoth`](themes/hoth/README.md) (a light theme of snow and ice) and [`coruscant`](themes/coruscant/README.md) (Art Deco onyx and champagne gold). Switch with `SUPER + T` (each theme appears as a planet) or `scripts/switch-theme.sh <theme>`: Hyprland, Quickshell, kitty, fish, Neovim and tmux reload in place, GTK apps switch to the theme's light or dark mode; Yazi follows on its next start.

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
- audio: `systemctl --user status pipewire pipewire-pulse wireplumber`, `wpctl status`.

## 2. Desktop environment

```bash
git clone https://github.com/Cheval-Paresseux/dotfiles.git ~/.dotfiles
~/.dotfiles/scripts/install.sh
sudo reboot
```

`scripts/install.sh` asks for `sudo` when needed and can be run again safely. It:

- installs the packages of the desktop (Hyprland, Quickshell, apps, fonts, development tools) from
  the repositories, and the Oxanium font from the AUR with `paru`; the list is at the top of the script,
- sets up Rust (`rustup default stable`, used by Neovim; language servers and formatters come from Mason),
- starts Ly on tty1 instead of the console login,
- makes fish the login shell,
- deletes the default configs of a fresh install (`~/.config/fish`, `hypr`, `kitty`, `nvim`, `quickshell`,
  `tmux`, `yazi`, when they are real directories) and links the `base` theme in their place.

It is meant for a fresh install: back up any of these directories you want to keep before running it.

After rebooting, pick the **Hyprland (UWSM)** session in Ly.

Bluetooth pairing works from the bar's Bluetooth popup: the shell runs a small BlueZ pairing agent
(`quickshell/scripts/bt-agent.py`) and shows the code to type on a keyboard, or asks to confirm one, inside the popup.
