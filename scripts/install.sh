#!/bin/bash
# Install the desktop environment on a working CachyOS system, then apply the death_star theme.
# Safe to run again: installed packages are skipped and existing settings are kept.
set -euo pipefail

SCRIPTS="$(dirname "$(realpath "$0")")"

if [ "$EUID" -eq 0 ]; then
  echo "Run as your user, not root: sudo is asked for when needed."
  exit 1
fi
if ! command -v pacman >/dev/null; then
  echo "pacman not found: this script targets CachyOS / Arch Linux."
  exit 1
fi

PACKAGES=(
  # Hyprland and session management
  sddm uwsm hyprland quickshell hypridle hyprpolkitagent
  # Video playback of the login screen
  qt6-multimedia-ffmpeg
  # Wayland utilities
  xdg-desktop-portal-hyprland wl-clipboard cliphist grim slurp brightnessctl playerctl
  # Desktop applications
  zen-browser-bin kitty tmux yazi neovim ripgrep fd fish eza
  # Bar services: battery, power profiles, Bluetooth pairing agent
  upower power-profiles-daemon python-dbus python-gobject
  # Fonts
  ttf-meslo-nerd ttf-fantasque-nerd noto-fonts noto-fonts-cjk
  # Development (base-devel compiles Neovim's tree-sitter parsers, Mason unpacks tools with unzip)
  git github-cli rustup base-devel unzip
  # AUR helper
  paru
)
AUR_PACKAGES=(ttf-oxanium ttf-playfair-variable ebgaramond-otf)

sudo pacman -S --needed "${PACKAGES[@]}"
paru -S --needed "${AUR_PACKAGES[@]}"

rustup default stable

"$SCRIPTS/install-sddm.sh"

fish_path="$(command -v fish)"
if [ "$(getent passwd "$USER" | cut -d: -f7)" != "$fish_path" ]; then
  chsh -s "$fish_path"
fi

# Default configs of a fresh install make way for the theme links
for app in fish hypr kitty nvim quickshell tmux yazi; do
  target="$HOME/.config/$app"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    rm -rf "$target"
  fi
done

"$SCRIPTS/switch-theme.sh" death_star

echo
echo "Done. Reboot and log in to the Hyprland (UWSM) session."
