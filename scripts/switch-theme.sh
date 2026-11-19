#!/bin/bash
# Link every application config of a theme into ~/.config and reload running apps.
# Usage: switch-theme.sh <theme>
#        switch-theme.sh --list    (one "name<TAB>planet image" line per theme)

THEMES_DIR="$(dirname "$(dirname "$(realpath "$0")")")/themes"
APPS=(fish hypr kitty nvim quickshell tmux yazi)
THEME="$1"

if [ "$THEME" = "--list" ]; then
  for dir in "$THEMES_DIR"/*/; do
    dir="${dir%/}"
    printf '%s\t%s\n' "$(basename "$dir")" "$dir/quickshell/assets/planet.svg"
  done
  exit 0
fi

if [ -z "$THEME" ]; then
  echo "Usage: switch-theme.sh <theme> | --list"
  exit 1
fi

if [ ! -d "$THEMES_DIR/$THEME" ]; then
  echo "Unknown theme: $THEME (see --list)"
  exit 1
fi

# Check everything before linking anything, so a failure never leaves a half-switched session
for app in "${APPS[@]}"; do
  if [ ! -d "$THEMES_DIR/$THEME/$app" ]; then
    echo "Missing configuration for $app in theme $THEME"
    exit 1
  fi
  target="$HOME/.config/$app"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "$target is not a link from a theme: move or remove it first"
    exit 1
  fi
done

for app in "${APPS[@]}"; do
  ln -sfn "$THEMES_DIR/$THEME/$app" "$HOME/.config/$app"
  echo "Linked $app"
done

# fish keeps universal variables (set -U) next to its config: share one file across themes
fish_vars="$HOME/.local/state/fish/fish_variables"
theme_vars="$THEMES_DIR/$THEME/fish/fish_variables"
mkdir -p "$(dirname "$fish_vars")"
if [ -f "$theme_vars" ] && [ ! -L "$theme_vars" ] && [ ! -e "$fish_vars" ]; then
  mv "$theme_vars" "$fish_vars"
fi
ln -sfn "$fish_vars" "$theme_vars"

# Apply the theme to the running session (Yazi picks it up on its next start)
if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
  hyprctl reload >/dev/null
  qs kill >/dev/null 2>&1
  hyprctl dispatch 'hl.dsp.exec_cmd("qs")' >/dev/null
  pkill -USR1 -x kitty
  pkill -USR1 -x nvim
  tmux source-file "$HOME/.config/tmux/tmux.conf" 2>/dev/null
  fish -c "set -U dotfiles_theme $THEME"
fi

echo "Theme switched to: $THEME"
