#!/bin/bash
whois $1 | awk -F': ' '/Registrant|Admin|Tech/ {gsub(/^ +| +$/, "", $2); f=$1; sub(" ", "$", f); if(f ~ /Street/) $2=$2" "; if(f ~ /Ext$/ && $2=="") $2=""; print f "," $2 }' > "$1.csv"
