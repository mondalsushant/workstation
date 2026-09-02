#!/usr/bin/env bash

# SPDX-FileCopyrightText: © 2026 Sushant Mondal <contact@sushantmondal.com>

###

# Sushant's Fedora Setup
# ======================
# > Let's copy Torvalds. I CRAVE FOR STABILITY. I WANT TO STOP SWITCHING DISTROS.
# > You have to change many things to make this script work for you.
# > I was too lazy to write the commands for the manual GUI stuff, if anyone can provide them, I will be honored.
# > Coming from an AlmaLinux guy, switching to Fedora was quite easy.
# Edited using: GNU nano, version 8.7.1
# Author: Sushant Mondal <contact@sushantmondal.com>

# Manually change this using the KDE Plasma GUI
# =============================================
# * Username: During setup, use your first name only, all lowercase. For example, `sushant`.
# * Date format @ Digital Clock: `MM/DD/YY (Short date)` -> `dddd, MMMM d, yyyy (Long date)`
# * Panel Height @ Panel Configuration: `43` -> `40`
# * Opacity @ Panel Configuration: `Adaptive` -> `Opaque`
# * Global Theme @ System Settings: `Breeze` -> `Fedora Light`
# * Icon @ Application Launcher Settings: `plasma-symbolic` -> `fedora-logo-icon`
# * Icon group @ Panel: Disable programs to be grouped.
# Note: Reorder this section alphabetically later.

# For Git
# =======
# * Import `public.asc` and `private.asc` GPG keys for Git.
# * SSH keys instead of HTTPS.

###

##########################
# !! RUN THIS WITH `sudo`.
##########################

dnf update -y

# User address for this system would be: Sushant Mondal <sushant@home.sushantmondal.com>.
hostnamectl set-hostname home.sushantmondal.com

###

# Dependencies
# ============

# Perf
# ----
dnf install -y snapd
ln -sf /var/lib/snapd/snap /snap
systemctl enable --now snapd.socket
systemctl enable --now snapd.apparmor || true
snap wait system seed.loaded
snap install auto-cpufreq
bash -c 'cat > /etc/auto-cpufreq.conf << "EOF"
[charger]
governor = powersave
energy_performance_preference = power
turbo = never
[battery]
governor = powersave
energy_performance_preference = power
turbo = never
EOF'
/var/lib/snapd/snap/bin/auto-cpufreq --stats
dnf install -y lm_sensors psensor
sensors-detect --auto

# Code editors
# ------------

# Visual Studio Code
# ++++++++++++++++++
# Refs: https://code.visualstudio.com/docs/setup/linux#_install-vs-code-on-linux
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc &&
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
dnf check-update &&
sudo dnf install code # or code-insiders

dnf install -y nano neovim

# Install the Google Chrome browser.
dnf install -y fedora-workstation-repositories
dnf config-manager setopt google-chrome.enabled=1
dnf install -y google-chrome-stable

###

# Apply the changes cleanly.
dnf reboot
