#!/usr/bin/env bash
set -euxo pipefail

# Add RPM packages
dnf5 -y install \
    weston \
    flatpak \
    greetd \
    pipewire \
    wireplumber \
    xorg-x11-server-Xwayland

# Install Flatpaks
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install -y --system flathub tv.kodi.Kodi
flatpak install -y --system flathub com.moonlight_stream.Moonlight

# Configure greetd autologin
install -Dm644 /ctx/configs/greetd.toml /etc/greetd/config.toml

# Enable greetd service
systemctl enable greetd

# (Optional) Disable GNOME/KDE/default targets if present
# systemctl set-default multi-user.target

echo "✅ PiTV system build complete."