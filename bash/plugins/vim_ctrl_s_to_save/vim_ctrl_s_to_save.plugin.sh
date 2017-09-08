#!/bin/bash

# Disable interpreting for Vim Ctrl+S to save file

function vim_mac {
	# osx users, use stty -g
	#local STTYOPTS="$(stty -g)"
	#stty stop '' -ixoff
	stty stop undef
	command vim $@
	stty start undef
	#stty "$STTYOPTS"
}

function vim_linux {
	# linux users, use stty --save
	#local STTYOPTS="$(stty --save)"
	#stty stop '' -ixoff
	stty stop undef
	command vim $@
	stty start undef
	#stty "$STTYOPTS"
}

function vim_cliclick {
	/usr/local/bin/vim --cmd 'let cliclick=1' $@
}

if is_true $__IS_MAC; then
	alias vim=vim_mac
	alias weakvim=vim_cliclick
else
	alias vim=vim_linux
fi

alias v=vim
