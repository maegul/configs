#!/bin/bash

sys_path=$(cat /etc/paths /etc/paths.d/*)

# sed - blanks + hash > delete; sub all has with nothing; delete blank lines (redundant with tr -s '\n')
prof_paths=$(sed '/^[[:blank:]]*#/d;s/#.*//;/^$/d' /Users/errollloyd/.dotfiles/profile_paths)

n_path=$( echo -e "$prof_paths\n$sys_path" | 
	awk '!seen[$0]{print$0}{seen[$0]++}' | 
	tr -s "\n" ":" 
	)

echo -e $n_path
# export PATH=n_path
