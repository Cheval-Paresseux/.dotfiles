#!/bin/bash
# Install every login screen (sddm/<name>) as the SDDM theme "dotfiles-<name>", make SDDM the display manager
# and start on <name> (star_wars by default). Usage: install-sddm.sh [name]
# Run it again after editing sddm/: the greeter runs as the sddm user, which cannot read ~, so the themes are copied.
# The file naming the current login screen belongs to the user, so switch-theme.sh can change it without sudo.
set -euo pipefail

SOURCE="$(dirname "$(dirname "$(realpath "$0")")")/sddm"
CURRENT="${1:-star_wars}"
CONF=/etc/sddm.conf.d/theme.conf
[ -f "$SOURCE/$CURRENT/Main.qml" ] || { echo "Unknown login screen: $CURRENT"; exit 1; }

sudo rm -rf /usr/share/sddm/themes/dotfiles /usr/share/sddm/themes/dotfiles-*
for source in "$SOURCE"/*/; do
  name="$(basename "$source")"
  target="/usr/share/sddm/themes/dotfiles-$name"
  # Only the videos listed in theme.conf are copied: videos/ may hold unused ones
  read -ra videos <<< "$(sed -n 's/^videos=//p' "$source/theme.conf" | tr ',' ' ')"
  sudo mkdir -p "$target/videos"
  (cd "$source" && sudo cp -r Main.qml metadata.desktop theme.conf posters "$target")
  (cd "$source/videos" && sudo cp "${videos[@]}" "$target/videos")
  echo "Installed login screen $name"
done

sudo mkdir -p "$(dirname "$CONF")"
sudo install -m 644 -o "$USER" -g "$(id -gn)" /dev/null "$CONF"
printf '[Theme]\nCurrent=dotfiles-%s\n' "$CURRENT" > "$CONF"

if systemctl is-enabled --quiet ly@tty1.service 2>/dev/null; then
  sudo systemctl disable ly@tty1.service
fi
sudo systemctl enable sddm.service

echo "SDDM login screen $CURRENT installed; it starts on the next boot."
