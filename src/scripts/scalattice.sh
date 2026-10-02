#!/usr/bin/env bash

# SPDX-FileCopyrightText: © 2026 Sushant Mondal <contact@sushantmondal.com>

TOKEN="${SLT_PROVIDER_TOKEN:?Set SLT_PROVIDER_TOKEN environment variable first.}"
set -euo pipefail
useradd -m -s /bin/bash scallatice
usermod -aG video,render scallatice
su - scallatice -c "
  curl -fsSL https://scalattice.cloud/install/agent | sh -s -- --token '$TOKEN'
  scalattice-agent status
"
