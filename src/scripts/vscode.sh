#!/usr/bin/env bash

# SPDX-FileCopyrightText: © 2026 Sushant Mondal <contact@sushantmondal.com>
#
# Refs: https://code.visualstudio.com/docs/setup/linux#_install-vs-code-on-linux

rpm --import https://packages.microsoft.com/keys/microsoft.asc &&
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | tee /etc/yum.repos.d/vscode.repo > /dev/null
dnf check-update &&
dnf install code # or code-insiders
