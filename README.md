# CachyOS Fresh Install

## Overview

| Component | Choice |
|---|---|
| OS | CachyOS |
| Display Manager | SDDM (own login screen in `sddm/`) |
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
- installs the login screen and makes SDDM the display manager (`scripts/install-sddm.sh`),
- makes fish the login shell,
- deletes the default configs of a fresh install (`~/.config/fish`, `hypr`, `kitty`, `nvim`, `quickshell`,
  `tmux`, `yazi`, when they are real directories) and links the `base` theme in their place.

It is meant for a fresh install: back up any of these directories you want to keep before running it.

After rebooting, log in to the **Hyprland (UWSM)** session.

## Login screen

`sddm/` is the SDDM theme: one of its live wallpapers, picked at random on every start (each screen
draws its own), loops muted, with the interface kept to the corners so the wallpaper stays in view:

- top left: a large thin clock, its colon in the accent, over the date;
- bottom left: the session, cycled with the arrows or a click on its name;
- bottom right: the user, a dark glass password pill whose submit button lights up in the accent,
  and round reboot and shut down buttons (shut down turns red on hover).

Each wallpaper brings its own accent (`accents` in `sddm/theme.conf`, one per video, taken from its colours):
warm sunrise amber for the Star Destroyer, icy blue for the Venators. Small spaced-out uppercase
captions led by a short accent line ("Welcome back", "Session", the date) tie the corners together;
"Wrong password" and "Caps Lock is on" replace the greeting, in red and yellow. A vignette and a soft
text shadow keep everything readable on bright frames, and the interface fades in when the screen appears.
The wallpaper's first frame (`sddm/posters/`) shows while the video loads.

SDDM runs as its own user and cannot read the home directory, so the theme is copied to
`/usr/share/sddm/themes/dotfiles`: run `scripts/install-sddm.sh` again after editing it.
Preview it in a window from the desktop with `sddm-greeter-qt6 --test-mode --theme ~/.dotfiles/sddm`
(power buttons are hidden in test mode).

To add a wallpaper, prepare it like the others (debanded and re-encoded with a fine grain, which hides
the compression blocks of low-bitrate downloads), save its first frame as a poster, and list it with an
accent in `sddm/theme.conf`:

```bash
ffmpeg -i <source> -vf "deband=1thr=0.015:2thr=0.015:3thr=0.015:range=22:blur=1,noise=c0s=3:c0f=t+u" \
    -c:v libx264 -crf 18 -preset slow -tune grain -pix_fmt yuv420p -movflags +faststart -an sddm/<name>.mp4
ffmpeg -i sddm/<name>.mp4 -frames:v 1 -vf scale=1920:-1 -q:v 3 sddm/posters/<name>.jpg
```

Bluetooth pairing works from the bar's Bluetooth popup: the shell runs a small BlueZ pairing agent
(`quickshell/scripts/bt-agent.py`) and shows the code to type on a keyboard, or asks to confirm one, inside the popup.
