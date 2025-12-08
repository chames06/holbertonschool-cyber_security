#!/bin/bash

# Check if running as root (or with sudo)
if [ "$(id -u)" -ne 0 ]; then
    echo "Error: This script must be run as root or via sudo."
    exit 1
fi

# Display last 5 login sessions (excluding reboots)
echo "Last 5 Login Sessions:"
last -n 5 | grep -v "^reboot\|^wtmp"
