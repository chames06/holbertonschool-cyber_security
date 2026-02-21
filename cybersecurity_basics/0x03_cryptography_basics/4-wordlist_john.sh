#!/bin/bash
printf '%b' "john --format=raw-sha256 --wordlist=/usr/share/wordlists/rockyou.txt \"$1\"\njohn --show --format=raw-sha256 \"$1\" | cut -d: -f2 > 4-password.txt\n" | bash
