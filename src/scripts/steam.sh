#!/usr/bin/env bash

# SPDX-FileCopyrightText: (C) 2026 Sushant Mondal <contact@sushantmondal.com>

# Prefer RPM Fusion over the Snap Store.
# Refs: https://techhut.tv/fedora-44-post-install-guide
dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

dnf update --refresh
dnf install -y steam

# Set up Steam automatically.
steam
