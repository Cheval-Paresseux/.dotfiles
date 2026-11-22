#!/bin/bash
# Install the login screen (sddm/) as the SDDM theme "dotfiles" and make SDDM the display manager.
# Run it again after editing sddm/: the greeter runs as the sddm user, which cannot read ~, so the theme is copied.
set -euo pipefail

THEME_SOURCE="$(dirname "$(dirname "$(realpath "$0")")")/sddm"
THEME_DIR=/usr/share/sddm/themes/dotfiles

# Only the videos listed in theme.conf are copied: sddm/videos may hold unused ones
read -ra videos <<< "$(sed -n 's/^videos=//p' "$THEME_SOURCE/theme.conf" | tr ',' ' ')"
sudo rm -rf "$THEME_DIR"
sudo mkdir -p "$THEME_DIR/videos"
(cd "$THEME_SOURCE" && sudo cp -r Main.qml metadata.desktop theme.conf posters "$THEME_DIR")
(cd "$THEME_SOURCE/videos" && sudo cp "${videos[@]}" "$THEME_DIR/videos")
sudo mkdir -p /etc/sddm.conf.d
printf '[Theme]\nCurrent=dotfiles\n' | sudo tee /etc/sddm.conf.d/theme.conf >/dev/null

if systemctl is-enabled --quiet ly@tty1.service 2>/dev/null; then
  sudo systemctl disable ly@tty1.service
fi
sudo systemctl enable sddm.service

echo "SDDM login screen installed; it starts on the next boot."
