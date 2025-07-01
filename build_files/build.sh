#!/usr/bin/env bash
set -euxo pipefail

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