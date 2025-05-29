#!/bin/bash

CONFIG="$HOME/.config/hypr/hyprland.conf"
LOCKFILE="/tmp/hyprland_conf.lock"
TMP_CONFIG="/tmp/hyprland.conf.tmp"
BACKUP="${CONFIG}.bak"

if [ -e "$LOCKFILE" ]; then
  echo "Config is locked by another process. Try again later."
  exit 1
fi

touch "$LOCKFILE"
cp "$CONFIG" "$BACKUP"
cp "$CONFIG" "$TMP_CONFIG"

${EDITOR:-nano} "$TMP_CONFIG"

cp "$TMP_CONFIG" "$CONFIG"

OUTPUT=$(hyprland --verify-config 2>&1)
STATUS=$?

if [ $STATUS -ne 0 ]; then
  echo "$OUTPUT"
  echo "Config error detected, reverting changes"
  cp "$BACKUP" "$CONFIG"
else
  echo "$OUTPUT"
  echo "Config looks good, changes saved"
fi

rm "$TMP_CONFIG" "$LOCKFILE"
