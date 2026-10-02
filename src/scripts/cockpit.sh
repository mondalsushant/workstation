#!/usr/bin/env bash

# SPDX-FileCopyrightText: (C) 2026 Sushant Mondal <contact@sushantmondal.com>

systemctl enable --now cockpit.socket
firewall-cmd --add-service=cockpit --permanent
firewall-cmd --reload
