#!/usr/bin/env bash

# SPDX-FileCopyrightText: © 2026 Sushant Mondal <contact@sushantmondal.com>
#
# Refs: https://github.com/micro-editor/micro#building-from-source

mkdir -p /tmp/git
cd /tmp/git
git clone https://github.com/micro-editor/micro
cd micro
make build
mv micro /usr/local/bin # optional
