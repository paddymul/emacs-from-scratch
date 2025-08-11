#!/bin/sh

## This commands runs a series of find commands that returns most wanted results first (quickly) and less wanted results later


search_root=$1
search_term=$2
preferred_directories=$3
preferred_extensions=$4

secondary_directories=$5
secondary_extensions=$6

never_directories=$7
never_extensions=$8

#for future os x installs
#brew install findutils

# we want gnu find, not bsd
#FIND_COMMAND=/opt/homebrew/bin/gfind
FIND_COMMAND="$(command -v gfind)"

#punt on nice error message for cant find gfind for now
#[ -n $FIND_COMMAND ] && { echo "ERROR: No 'gfind found'." ; exit 1 ; }

#we want to cut results in case a large compiled file ends up in the results
CUT_THRESHHOLD=300


#gfind ~/buckaroo -not \( -type d -iregex ".*\\.\\(dist\\|node_modules\\).*" \) -not \( -iregex ".*\\.\\(html\\|pyc\\)$" \) -and \( -iregex ".*\\.\\(py\\|tsx?\\)$" \)




#preferred search
$FIND_COMMAND $search_root\
	      -type f  -iregex $preferred_extensions \
	      -print0 \
	      -not \(  -iregex $secondary_directories \) \
	      -not \(  -iregex $secondary_extensions \) \
	      -not \(  -iregex $never_directories \) \
	      -not \(  -iregex $never_extensions \) \
    | xargs -0 grep --null --line-number  $search_term  # | cut -c $CUT_THRESHHOLD  This doesn't work in an interactive terminal


$FIND_COMMAND $search_root\
	      -type f  -iregex $secondary_extensions \
	      -print0 \
	      -and \(  -iregex $secondary_directories \) \
              -not \(  -iregex $preferred_extensions \) \
	      -not \(  -iregex $never_directories \) \
	      -not \(  -iregex $never_extensions \) \
    | xargs -0 grep --null  --line-number $search_term   # | cut -c $CUT_THRESHHOLD  This doesn't work in an interactive terminal

#/Users/paddy/.emacs.d/personal/find_script.sh "/Users/paddy/buckaroo" "color_map" "" ".*\.\(py\)$" ".*\.\(venv\|foo|\.venv\).*" ".*\.\(jsx?\|tsx?\)$" ".*\.\(\.\(?:git\|ruff\)\|dist\|pycache\).*" ".*\.\(\.d\.ts\|pyc\)$" | wc -l
#returns reasonable results


