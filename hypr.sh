#!/bin/bash
set -e

echo "updating system..."
sudo pacman -Syu --noconfirm

echo "installing hyprland and deps..."
sudo pacman -S --noconfirm hyprland waybar mako alacritty networkmanager

echo "enabling and starting NetworkManager service..."
sudo systemctl enable NetworkManager.service
sudo systemctl start NetworkManager.service

echo "creating basic hyprland config..."

mkdir -p ~/.config/hypr
cat > ~/.config/hypr/hyprland.conf << EOF
# basic hyprland config
monitor=eDP-1,1920x1080@60
exec=waybar &
exec=alacritty &
exec=mako &
exec=nm-applet &
EOF

echo "done! launch hyprland by running 'Hyprland'"
