#!/bin/bash
subfinder -d $1 -silent | tee /dev/tty | dnsx -silent -resp-only -a -o $1.txt
