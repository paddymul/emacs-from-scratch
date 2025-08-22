incrmeentally add


python skeleton

default ways of moving by larger bojects



ideally super would be for emacs font size, buffer movement
ctrl for text movemten in abuffer


from left ctrl, then super  option (weird apple specific), then meta (command), then spacebar

meta and control are very strong muscle memory for me
i overwhelmingly use control form caps


C-M-a beginning of defun
C-M-e end of defun

an annoyance is that sometimes it goes to the end of class, and it's not clear what class I'm in

In an ideal world when I type C-M i'd get an overlay of jump points
av
specific command "av-goto character with timer"


wishlist item.  table formatting in code 
look up align-regexp for that
---

double emitting of commands

M-x remove-hook   interactively removes an element from a list


pay attention to eglot-server-programs
alist that defines the major modes and server modes


other lsp fucntionality 
completion
and linting


## common text manipulations

I get a python styled dictionary, but want it js styled
from
```
    { "field": "a", "headerName": "b", "cellDataType": false },
```
to
```
    { field: "a", headerName: "a", cellDataType: false },
```

so step one, writing the formatting function, then remembering to use it

I would like a menu to pop up with just "paddy" commands relevant to the buffer that I ahve defined
along with their keyboard shortcuts so I remember them 



```
const config1:ColDef[] = [
    { field: "a", headerName: "a", cellDataType: false },
    { field: "b", headerName: "b", cellDataType: false },
    { "field": "c", "headerName": "c", "cellDataType": false }
  ]

```


## Search in project

I search with find, grep to exclude some stuff, then xargs grep

What's your recommended find in project

I do different file greps (excluding or including files depending on the directory

generally I never want to search pycache or .git

when I'm searching js I almost always want to excude node modules

## dirs get unsyced

Meta Super F to find file at point, but messes up when the directory is unknown

## cancelling out of a minibuffer selector
I have to Ctrl-G a bunch

## Shell
I have long commands I run in each shell directory.  sometimes my history gets clobbered.  sometimes I try to store these in git for that repo, but that becomes a mess changing between branches

suggestions

./scripts/partial_build.sh && pip install --force-reinstall dist/*.whl



When I reverse shell search, I want it to start from the current point in time evey time, not iterated further looks bakc

why, when i have y-or-no-p do I have to type yes for so many close editted files


## eglot on my own

npm i -g  typescript-language-server

from shell
which typescript-language-server
/Users/paddy/.nvm/versions/node/v18.20.4/bin/typescript-language-server


What's the interaction between nvm and eglot?


What are the common emacs key bindings for these eglot commands


M-. goto definition
M-, go back
M-? find usages other window
C-; quick fix modal popup

## Problem with where require 'me is

if it's at the bottom of init.el I get zsh as expected
at the top, I get bash.

I want zsh because that's setup


## convience command

Ok, I have a bunch of paths around, how to normalize that

I want a command that runs npm install



## How to jump to line number


paddy@Paddys-Air buckaroo % uv run mypy buckaroo/pluggable_analysis_framework/analysis_management.py
buckaroo/pluggable_analysis_framework/analysis_management.py:256: error: Missing positional argument "ordered_objs" in call to "produce_summary_df"  [call-arg]
Found 1 error in 1 file (checked 1 source file)

How do I got staright to to line 256?

Should I be running this in compile mode?


## 5/30

Why does buckaroo_widget open differently into python mode not python-ts-mode

I understand how to use add-to-alist interactively

How do I reasonably do replace-in-alist so I don't have to restart emacs?

Use M-x remove-hook  and search for val
don't sowrry about auto-mode-alist containing extra values, as long as it does the right thing when you open a file



### search

counsel-outline  search headings


ivy-counsel mo

Consult provides the preview




### Shell setup
I want a couple of shells to open up each time I start

buckaroo shell, with a psecific uv environment activated


marimo shell same venv activated, different dir and command run



## 6/6

Continue with find/xargs setup setup.  There are conflicts with ivy
happy to dismiss ivy #Done


also tab completion in shell isn't consistent

corfu gives an overlay of completions


maybe get to better shell switching

maybe python mode compliaing about errors not related to my project



M-x dirs sometimes


s-b search through current major mode buffers
if while search through current major mode buffers, search through all mode buffers



## backlog

How to make a command for lsof port -> process
is there a proced?

This is porbalby a low priority change

## 6/13

how to make "make-directory" a keypress instead of an M-x command?


how to change the vertico sort function
I want to sort by "same mode", "directory distance"


Another buffer switch completion idea...
How do I set it up so the same major mode buffers are listed below where the cursor starts
and the 5 most recent other buffers are listed above


... or for major modes that related majore modes are searched.  TS, TSX, and JS are all related modes
#### Prot says
This will require custom coding


### syntax highlinghting gets in the way

I couldn't find the missing comma after rewritten_col_name:'a'},
because of all the squigles in python mode

        assert assert_dict_eq({
            'a': {'distinct_count': 4, 'distinct_per':1.0, 'len': 4,
                  'orig_col_name':'normal_int_series', 'rewritten_col_name':'a'}
            'b': {'distinct_count': 0, 'distinct_per':0, 'len': 0,
                  'orig_col_name':'empty_na_ser', 'rewritten_col_name':'b'},
            'c': {'distinct_count': 2, 'distinct_per':0, 'len': 0,
                  'orig_col_name':'float_nan_ser', 'rewritten_col_name':'c'}},

We also need to switch the theme/faces
I hate python inlay mode because it suggests keyword arguments everywhere

turn off flymake mode

also the inly face is the same as the comment face




## Testing

project-compile
compile-command

use .dir-locals.el

project-compile default is M-x p c


How to scroll to bottom or first error when complete

fix regex for jest test failures


shortcuts for rerun last failed test
ideal world:
when a save is made to a relevant file (in project, or in project and of type (pytest/pnpm run test)
last failed is rerun, results reported asynchonously (I don't want a wholewindow, maybe just a double stacked modeline)



### find-grep

How do I pop the minibuffer out to a different window for deeper work? .. with notes
That's important when delving deep into a project, not relevant when I know what I want to find but don't know where to find it


### completion modes
I want the case insensitive matching


### indentation

I really dislike the python indentation

I also want better auto-detection of typescript indentation


# did I bork something with this change

- '(package-selected-packages
-   '(all-the-icons-dired cider command-log-mode ;; conda consult corfu
-			 counsel-projectile coverlay csv csv-mode
-			 dap-mode dired-hide-dotfiles dired-open
-			 dired-single doom-themes ein emacsql-sqlite
-			 envrc eshell-git-prompt eterm-256color forge
-			 general helpful jupyter lsp-pyright lsp-ui
-			 marginalia markdown-preview-mode mmm-mode
-			 no-littering org-bullets origami
-			 poly-markdown python-mode pyvenv
-			 rainbow-delimiters reformatter scss-mode
-			 tree-sitter-langs treesit-auto
-			 typescript-mode use-package vertico
-			 visual-fill-column which-key yaml-mode
-			 yasnippet))
+ '(package-selected-packages nil)
I deleted a bunch of packages from ~/.emacs.d/elpa because I was getting "older than compiled" warnings on startup and I found them tiring


### What to work on next
corfu?
window mangement?
magit?   probably not because I'm not doing a lot of collaboration where it matters

;;emacs startup open buffers?


## tips before coaching session

make sure .emacs git repo is comitted


## grep refinements

filter out files with more than 5k lines
or any match on a line at char greater than 1k

those are generated files

but later


## Find file enhancement

I frequently want to open the relevant package.json or README or...
from a file

from C-x C-f, lets make another modemap


S-r -> closest README
S-p -> closest package.json

let's try to get this modemap into switch-buffer too.  in fact for this type of operation, I just want the file open, so in switch buffer, just open the appropriate file, I don't want to think did I open that buffer



# 7/4/2025


Let's do some shell startup scripts


how to write Test this file
how to write show tests that reference this function (using lsp/eglot) and run those tests

probably need a pytest specific command



# 7/18/2025

## grep,  i need to exclude more files, and long lines
Searching for DataFlow
I know that this is a python concept, not JS/TS
so I wouldn't want JS/TS files to show up
I also would want to exclude .venv by default

at a minimum sort search results putthing files of same extension family at the top
py -> [py]
js -> [js, ts, jsx, tsx]
ts -> [ts, js, tsx, jsx]
jsx -> [jsx, tsx, js, ts]
tsx -> [tsx, jsx, ts, js]

assume a program

fast-find-grep exclude-dir-list always-exclude-dir-list  extension-sort-order grep-args
# first run find exluding exlude-dir-list, sort by extension-sort-order, run grep-args on this, 
# then run specifically on  exlude-dir-list, sort by extension-sort-order, run grep-args on this
/opt/homebrew/opt/findutils/libexec/gnubin/find 
/opt/homebrew/opt/findutils/libexec/gnubin/find  . -not \( -iregex ".*\.?\(config\|pass\|Builds\).*" -prune \) -type d 

always exclude
.git .mypy_cache ruff_cache pytest_cache __marimo__

the exclude command 
time /opt/homebrew/opt/findutils/libexec/gnubin/find  . -not \( -iregex ".*\.?\(node_modules\|venv\|git\|mypy_cache\|ruff_cache\|pytest_cache\|__marimo__\).*" -prune \) -type f | wc -l



## dired, how to toggle hidden files

C-x C-f, how to make backward kill word not add to kill-ring



big_file.md,  long python lines by default

find-file-at-point doesn't work with special characters
like /Users/paddy/sonderco/app//client_magic/(dashboard)/[client_slug]/[hash_slug]/page.tsx



## 8/22
work on tab formatting

~/sonderco/app/api/webhooks/attio/route.ts
