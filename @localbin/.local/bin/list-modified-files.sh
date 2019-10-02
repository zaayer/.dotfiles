#!/usr/bin/env bash

pacman -Qii | awk '/^MODIFIED/ {print $2}'
