#!/bin/bash
printf 'HOME=/tmp john --wordlist=/usr/share/wordlists/rockyou.txt "$1"\nHOME=/tmp john --show "$1" | grep ":" | cut -d ":" -f 2 > 4-password.txt\n' | bash -s -- "$1"
