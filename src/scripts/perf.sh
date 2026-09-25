#!/usr/bin/env bash

# SPDX-FileCopyrightText: © 2026 Sushant Mondal <contact@sushantmondal.com>

cp ../.config/auto-cpufreq.conf /etc/auto-cpufreq.conf
sensors-detect --auto
# /var/lib/snapd/snap/bin/auto-cpufreq --stats
