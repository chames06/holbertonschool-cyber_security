#!/bin/bash
subfinder -silent -d $1 | tee /dev/tty | xargs -I{} sh -c 'echo -n "{},"; dig +short {} | head -n 1' > "$1".txt
