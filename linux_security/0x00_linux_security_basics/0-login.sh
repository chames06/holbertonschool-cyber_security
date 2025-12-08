#!/bin/bash
[ "$(id -u)" -ne 0 ] && { echo "Error: Must run as root"; exit 1; }; who -b | awk '{print $3,$4}' | head -n 5
