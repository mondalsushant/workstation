#!/usr/bin/env bash

# SPDX-FileCopyrightText: © 2026 Sushant Mondal <contact@sushantmondal.com>

bash cockpit.sh
bash install_dnf.sh
bash snap.sh
bash install_snap.sh
bash perf.sh
bash vscode.sh
bash micro.sh
dnf config-manager setopt google-chrome.enabled=1
reboot
