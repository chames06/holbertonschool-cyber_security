#!/bin/bash
[ "$(id -u)" -ne 0 ] && { echo "Error: Must run as root"; exit 1; }; last -n 5 | grep -v "^reboot\|^wtmp"
