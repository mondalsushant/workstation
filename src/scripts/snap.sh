#!/usr/bin/env bash

# SPDX-FileCopyrightText: © 2026 Sushant Mondal <contact@sushantmondal.com>

ln -sf /var/lib/snapd/snap /snap
systemctl enable --now snapd.socket
systemctl enable --now snapd.apparmor || true
snap wait system seed.loaded
