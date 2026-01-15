#!/bin/bash
curl -s -H "Host: $1" -X POST --data "$3" "$2"
