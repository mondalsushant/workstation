#!/usr/bin/env bash

# SPDX-FileCopyrightText: (C) 2026 Sushant Mondal <contact@sushantmondal.com>

set -euo pipefail
dnf install -y pipx
pipx ensurepath
pipx install wpm
pipx inject wpm "setuptools==81.0.0" --force
wpm -h
