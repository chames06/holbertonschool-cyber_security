#!/bin/bash
subfinder -d $1 -silent | tee >(while read domain; do dig +short $domain A | head -1 | xargs -I {} echo "$domain,{}"; done > $1.txt)
