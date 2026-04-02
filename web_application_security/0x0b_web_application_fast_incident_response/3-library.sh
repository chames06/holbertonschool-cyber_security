#!/bin/bash
ip=$(awk '{print $1}' logs.txt | sort | uniq -c | sort -nr | head -n1 | awk '{print $2}')
grep ^$ip logs.txt | cut -d'"' -f6 | sort | uniq -c | sort -nr | head -n1 | awk '{print $2}'
