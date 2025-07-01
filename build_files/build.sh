#!/usr/bin/env bash
set -euxo pipefail

# Add RPM Fusion repos for Fedora (Free + Non-Free)
curl -o /etc/yum.repos.d/rpmfusion-free.repo \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free.repo

curl -o /etc/yum.repos.d/rpmfusion-nonfree.repo \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree.repo

# Add RPM packages
dnf5 install \
    weston \
    moonlight-embedded \
    kodi \
    greetd \
    pipewire \
    wireplumber \
    xorg-x11-server-Xwayland

# Configure greetd autologin
install -Dm644 /ctx/configs/greetd.toml /etc/greetd/config.toml

# Enable greetd service
systemctl enable greetd

# (Optional) Disable GNOME/KDE/default targets if present
# systemctl set-default multi-user.target

echo "✅ PiTV system build complete."