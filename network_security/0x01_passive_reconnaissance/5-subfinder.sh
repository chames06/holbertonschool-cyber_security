#!/bin/bash
subfinder -d $1 -silent | tee /dev/tty | dnsx -silent -a -resp -no-color | awk '{print $1","$3}' | tr -d '[]' > $1.txt
