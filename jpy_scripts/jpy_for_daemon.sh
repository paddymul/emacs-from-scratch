#!/bin/bash

set -e
set -o pipefail

# otherwise can't find conda
export PATH=$HOME/anaconda3/bin:$PATH

# either of these will make conda activate work inside a bash script
# https://stackoverflow.com/questions/34534513/calling-conda-source-activate-from-bash-script
# https://github.com/conda/conda/issues/7980
#source $(conda info --base)/etc/profile.d/conda.sh
eval "$(conda shell.bash hook)"

conda activate ds-play
OUTFILE=~/.jupyter.out
jupyter notebook --notebook-dir=/home/paddy/code/notebook-play/ --no-browser &> $OUTFILE

exit $?
