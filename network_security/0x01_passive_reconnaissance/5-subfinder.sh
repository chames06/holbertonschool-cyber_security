#!/bin/bash
subfinder -d $1 -silent | tee /dev/tty | dnsx -silent -a -resp -o $1.txt
