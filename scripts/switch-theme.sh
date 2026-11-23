#!/bin/bash
# Link every application config of a theme into ~/.config and reload running apps.
# Usage: switch-theme.sh <theme>
#        switch-theme.sh --list    (one "name<TAB>emblem<TAB>group" line per theme, base left out)

THEMES_DIR="$(dirname "$(dirname "$(realpath "$0")")")/themes"
APPS=(fish hypr kitty nvim quickshell tmux yazi)
# The login screen (sddm/<name>) shown after switching to a theme of each group
declare -A LOGIN_SCREENS=([star_wars]=star_wars [characters]=samurai)
# Written by install-sddm.sh, which gives it to the user
SDDM_CONF=/etc/sddm.conf.d/theme.conf
THEME="$1"

# A theme is a directory with a quickshell/ config, directly in themes/ or in a group (themes/star_wars/hoth)
theme_dirs() {
  find "$THEMES_DIR" -mindepth 2 -maxdepth 3 -type d -name quickshell -printf '%h\n' | sort
}

if [ "$THEME" = "--list" ]; then
  # base is the template for new themes: still switchable by name, but not offered in the picker
  theme_dirs | grep -vxF "$THEMES_DIR/base" | while read -r dir; do
    group="$(dirname "$dir")"
    [ "$group" = "$THEMES_DIR" ] && group=""
    printf '%s\t%s\t%s\n' "$(basename "$dir")" "$dir/quickshell/assets/emblem.svg" "$(basename "$group")"
  done
  exit 0
fi

if [ -z "$THEME" ]; then
  echo "Usage: switch-theme.sh <theme> | --list"
  exit 1
fi

THEME_DIR="$(theme_dirs | awk -F/ -v name="$THEME" '$NF == name { print; exit }')"
if [ -z "$THEME_DIR" ]; then
  echo "Unknown theme: $THEME (see --list)"
  exit 1
fi

# Check everything before linking anything, so a failure never leaves a half-switched session
for app in "${APPS[@]}"; do
  if [ ! -d "$THEME_DIR/$app" ]; then
    echo "Missing configuration for $app in theme $THEME"
    exit 1
  fi
  target="$HOME/.config/$app"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "$target is not a link from a theme: move or remove it first"
    exit 1
  fi
done

mkdir -p "$HOME/.config"
for app in "${APPS[@]}"; do
  ln -sfn "$THEME_DIR/$app" "$HOME/.config/$app"
  echo "Linked $app"
done

# fish keeps universal variables (set -U) next to its config: share one file across themes
fish_vars="$HOME/.local/state/fish/fish_variables"
theme_vars="$THEME_DIR/fish/fish_variables"
mkdir -p "$(dirname "$fish_vars")"
if [ -f "$theme_vars" ] && [ ! -L "$theme_vars" ] && [ ! -e "$fish_vars" ]; then
  mv "$theme_vars" "$fish_vars"
fi
touch "$fish_vars"
ln -sfn "$fish_vars" "$theme_vars"

# The login screen follows the theme's group from the next login on (not for ungrouped themes like base)
login_screen="${LOGIN_SCREENS[$(basename "$(dirname "$THEME_DIR")")]:-}"
if [ -n "$login_screen" ] && [ -w "$SDDM_CONF" ]; then
  printf '[Theme]\nCurrent=dotfiles-%s\n' "$login_screen" > "$SDDM_CONF"
  echo "Login screen: $login_screen"
fi

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
