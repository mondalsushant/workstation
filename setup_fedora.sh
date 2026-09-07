#!/usr/bin/env bash

# SPDX-FileCopyrightText: © 2026 Sushant Mondal <contact@sushantmondal.com>

###

# Sushant's Fedora Setup
# ======================
# > Let's copy Torvalds. I CRAVE STABILITY. I WANT TO STOP SWITCHING DISTROS.
# > You have to change a lot of things to make this script work for you.
# > I was too lazy to write the commands for the manual GUI stuff; if anyone can provide them, I will be honored.
# > Coming from an AlmaLinux guy, switching to Fedora was quite easy.
# Edited using: micro 2.0.16-dev.77 (393cf248) [compiled on September 04, 2026]
# Author: Sushant Mondal <contact@sushantmondal.com>

# Manually change this using the KDE Plasma GUI
# =============================================
# * Username: During setup, use your first name only, all lowercase. For example, `sushant`
# * Date format @ Digital Clock: `MM/DD/YY (Short date)` -> `dddd, MMMM d, yyyy (Long date)`
# * Panel Height @ Panel Configuration: `43` -> `40`
# * Opacity @ Panel Configuration: `Adaptive` -> `Opaque`
# * Global Theme @ System Settings: `Breeze` -> `Fedora Light`
# * Icon @ Application Launcher Settings: `plasma-symbolic` -> `fedora-logo-icon`
# * Icon group @ Panel: Disable programs from being grouped.
# * Pointers @ System Settings: `Breeze Dark` -> `Breeze Light`
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
rpm --import https://packages.microsoft.com/keys/microsoft.asc &&
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | tee /etc/yum.repos.d/vscode.repo > /dev/null
dnf check-update &&
dnf install code # or code-insiders

# `micro`
# +++++++
# Refs: https://github.com/micro-editor/micro#building-from-source
dnf install -y golang
mkdir -p /tmp/git
cd /tmp/git
git clone https://github.com/micro-editor/micro
cd micro
make build
mv micro /usr/local/bin # optional

# Though `nano` should already be pre-installed.
dnf install -y nano neovim

# Install the Google Chrome browser.
dnf install -y fedora-workstation-repositories
dnf config-manager setopt google-chrome.enabled=1
dnf install -y google-chrome-stable

# Drawing
dnf install -y gimp inkscape

###

# Apply the changes cleanly.
dnf reboot
