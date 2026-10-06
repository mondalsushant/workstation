#!/usr/bin/env bash

# SPDX-FileCopyrightText: (C) 2026 Sushant Mondal <contact@sushantmondal.com>

set -euo pipefail
TOKEN="${SLT_PROVIDER_TOKEN:?Set SLT_PROVIDER_TOKEN environment variable first.}"
dnf install -y curl

# Only works on AMD processors. When NVIDIA-based machines will face problems, send a patch!
dnf install -y mesa-vulkan-drivers vulkan-loader

id -u scalattice &>/dev/null || useradd -m -s /bin/bash scalattice
usermod -aG video,render scalattice
su - scalattice -c "
  curl -fsSL https://scalattice.cloud/install/agent | sh -s -- --token '$TOKEN'
  scalattice-agent status
"

# Works with `scalattice-agent 1.1.133` or later.
loginctl enable-linger scalattice
su - scalattice -c "XDG_RUNTIME_DIR=/run/user/\$(id -u scalattice) systemctl --user start scalattice-agent"
su - scalattice -c "XDG_RUNTIME_DIR=/run/user/\$(id -u scalattice) systemctl --user status scalattice-agent" || true
su - scalattice -c "XDG_RUNTIME_DIR=/run/user/\$(id -u scalattice) scalattice-agent status"
