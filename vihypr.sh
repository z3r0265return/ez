#!/bin/bash

CONFIG="$HOME/.config/hypr/hyprland.conf"
LOCKFILE="/tmp/hyprland_conf.lock"
BACKUP="${CONFIG}.bak"

if [ -e "$LOCKFILE" ]; then
  echo "Config is locked by another process. Try again later."
  exit 1
fi

touch "$LOCKFILE"

cp "$CONFIG" "$BACKUP"

${EDITOR:-nano} "$CONFIG"

OUTPUT=$(hyprland --verify-config "$CONFIG" 2>&1)
STATUS=$?

echo "$OUTPUT"

if [ $STATUS -ne 0 ]; then
  echo "Config error detected, restoring backup"
  cp "$BACKUP" "$CONFIG"
else
  echo "Syntax looks good, changes saved"
fi

rm "$LOCKFILE"
