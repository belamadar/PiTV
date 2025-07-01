#!/usr/bin/env bash
set -euxo pipefail

# Add RPM Fusion repos for Fedora (Free + Non-Free)
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Add RPM packages
dnf5 install \
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