#!/bin/bash
# Copy ~/Documents, without .git and build directories (Rust target/, node_modules/),
# to <usb key>/<YYYY-MM-DD>/ on the mounted USB key.
# Usage: backup-documents.sh [mount point]   (needed only when several keys are mounted)

SOURCE="$HOME/Documents"

if [ -n "$1" ]; then
  KEY="$1"
else
  keys=()
  for dir in /run/media/"$USER"/*/; do
    mountpoint -q "$dir" && keys+=("${dir%/}")
  done
  if [ "${#keys[@]}" -ne 1 ]; then
    echo "Found ${#keys[@]} mounted USB keys in /run/media/$USER; plug in (and mount) one, or pass its mount point."
    printf '  %s\n' "${keys[@]}"
    exit 1
  fi
  KEY="${keys[0]}"
fi

if ! mountpoint -q "$KEY"; then
  echo "$KEY is not a mount point."
  exit 1
fi

DEST="$KEY/$(date +%F)"
echo "Copying $SOURCE to $DEST"
# USB keys are usually FAT/exFAT: no permissions, owners or symlinks, so copy files and times only,
# following symlinks (e.g. Documents/code/dotfiles) to copy what they point to
rsync -rtL --exclude=.git --exclude=target/ --exclude=node_modules/ --info=progress2 "$SOURCE/" "$DEST/" || exit 1
echo "Writing to the key..."
sync -f "$DEST"
echo "Done: $(du -sh "$DEST" | cut -f1) in $DEST"
