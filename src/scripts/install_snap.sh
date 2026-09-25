#!/usr/bin/env bash

# SPDX-FileCopyrightText: © 2026 Sushant Mondal <contact@sushantmondal.com>

while read -r snap_pkg || [[ -n "$snap_pkg" ]]; do
  if [[ -z "$snap_pkg" ]]; then
    continue
  fi
  snap install "$snap_pkg"
done < ../pkgs/snap.txt
