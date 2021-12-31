#!/usr/bin/env bash
OUTFILE=~/.jupyter.out
/home/paddy/.emacs.d/jpy_scripts/ein_jupyter.sh notebook --notebook-dir=/home/paddy/code/notebook-play/ --no-browser &> $OUTFILE
