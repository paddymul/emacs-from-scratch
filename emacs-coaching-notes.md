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


## 6/13

how to make "make-directory" a keypress instead of an M-x command?

How to make a command for lsof port -> process
is there a proced?

This is porbalby a low priority change


