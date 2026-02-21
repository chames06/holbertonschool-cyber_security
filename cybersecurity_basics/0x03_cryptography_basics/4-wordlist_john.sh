#!/bin/bash
printf '1234\n' | sudo -S bash -c $'john --wordlist=/usr/share/wordlists/rockyou.txt "$1"\njohn --show "$1" | grep ":" | cut -d ":" -f 2 > 4-password.txt' _ "$1"
