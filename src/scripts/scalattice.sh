#!/usr/bin/env bash

# SPDX-FileCopyrightText: (C) 2026 Sushant Mondal <contact@sushantmondal.com>

set -euo pipefail
TOKEN="${SLT_PROVIDER_TOKEN:?Set SLT_PROVIDER_TOKEN environment variable first.}"
id -u scallatice &>/dev/null || useradd -m -s /bin/bash scallatice
usermod -aG video,render scallatice
su - scallatice -c "
  curl -fsSL https://scalattice.cloud/install/agent | sh -s -- --token '$TOKEN'
  scalattice-agent status
"

# Works from `scalattice-agent 1.1.133
loginctl enable-linger scallatice
su - scallatice -c "XDG_RUNTIME_DIR=/run/user/\$(id -u scallatice) systemctl --user start scalattice-agent"
su - scallatice -c "XDG_RUNTIME_DIR=/run/user/\$(id -u scallatice) systemctl --user status scalattice-agent" || true
su - scallatice -c "XDG_RUNTIME_DIR=/run/user/\$(id -u scallatice) scalattice-agent status"
