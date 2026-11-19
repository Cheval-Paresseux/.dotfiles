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

Themes live in `themes/`: [`base`](themes/base/README.md) (neutral greys), [`tatooine`](themes/tatooine/README.md) (desert dusk), [`death_star`](themes/death_star/README.md) (Imperial gunmetal and saber red), [`dagobah`](themes/dagobah/README.md) (misty swamp and a blue saber), [`hoth`](themes/hoth/README.md) (a light theme of snow and ice) and [`coruscant`](themes/coruscant/README.md) (Art Deco onyx and champagne gold). Switch with `SUPER + T` (each theme appears as a planet) or `scripts/switch-theme.sh <theme>`: Hyprland, Quickshell, kitty, fish, Neovim and tmux reload in place; Yazi follows on its next start.

# I. Installation and Basic Packages

## 1. CachyOS Installation

Boot from the CachyOS USB installer.

Installation preferences:

- No Desktop Environment
- No Firefox

After installation, update the system:

```bash
sudo pacman -Syu
update
```

## 2. Package Installation

### Hyprland and Session Management

```bash
sudo pacman -S --needed \
    ly \
    uwsm \
    hyprland \
    quickshell \
    hypridle \
    hyprpolkitagent
```

### Wayland Utilities

```bash
sudo pacman -S --needed \
    xdg-desktop-portal-hyprland \
    wl-clipboard \
    cliphist \
    grim \
    slurp \
    brightnessctl \
    playerctl
```

### Desktop Applications

```bash
sudo pacman -S --needed \
    zen-browser \
    kitty \
    tmux \
    yazi \
    neovim \
    ripgrep \
    fd \
    fish
```

### Fonts

The terminal, editor and Quickshell icons use MesloLGM Nerd Font (preinstalled on CachyOS):

```bash
sudo pacman -S --needed ttf-meslo-nerd
```

The tatooine, death_star and hoth themes also use Oxanium for their signage: `paru -S ttf-oxanium` (AUR).
The dagobah theme uses Fantasque Sans Mono for its terminal and signage: `sudo pacman -S --needed ttf-fantasque-nerd`.
The coruscant theme uses Noto Sans Display for its headlines (part of `noto-fonts`, preinstalled on CachyOS).

### Development

```bash
sudo pacman -S --needed \
    git \
    github-cli \
    rustup

rustup default stable    # cargo, rustfmt and clippy, used by Neovim for Rust
```

Language servers and formatters for Neovim (rust-analyzer, basedpyright, ruff, ...) are installed automatically by Mason.

## 3. Checking & Enabling System Services

### Networking, Bluetooth and Display Manager

Check (preinstalled with cachyos base packages):

```bash
sudo systemctl status NetworkManager
sudo systemctl status bluetooth

systemctl --user status pipewire
systemctl --user status pipewire-pulse
systemctl --user status wireplumber

wpctl status
```

Bluetooth pairing works from the bar's Bluetooth popup: the shell runs a small BlueZ pairing agent
(`quickshell/scripts/bt-agent.py`) and shows the code to type on a keyboard, or asks to confirm one, inside the popup. It needs `sudo pacman -S --needed python-dbus python-gobject`.

Use the **Hyprland (UWSM)** session from Ly:

```bash
sudo systemctl enable ly@tty1.service
sudo systemctl disable getty@tty1.service
```

# II. Getting Configuration Files

## 1. Git and GitHub

Configure Git & Authenticate with GitHub:

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"

gh auth login
```

## 2. Dotfiles

```bash
cd ~/.config
git clone https://github.com/Cheval-Paresseux/dotfiles.git

chmod +x ~/.config/dotfiles/scripts/switch-theme.sh
~/.config/dotfiles/scripts/switch-theme.sh base

sudo reboot
```
