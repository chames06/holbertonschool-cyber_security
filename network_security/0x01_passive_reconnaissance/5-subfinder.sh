#!/bin/bash
subfinder -d $1 -silent -oJ | tee >(jq -r .host) >(jq -r '"\(.host),\(.ip[0])"' > $1.txt) > /dev/null
