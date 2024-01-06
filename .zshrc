# > initialise completions
autoload -Uz compinit
compinit


# > Prompt

setopt PROMPT_SUBST

# >> RGB function

function RGBcolor {
	echo "16 + $1 * 36 + $2 * 6 + $3" | bc
}

# >> time symbol
# For converting current time to col idx from file
source ~/.dotfiles/date_cols_test.sh

# unicode for a filled sun symbol and a moon
time_sun_symbol="\xe2\x98\x80"
time_moon_symbol="\xe2\x98\xbe"

print_time_symbol()
{
	date_now=$(date +"%H")
	if [[ $date_now > 20 || $date_now < 5 ]]; then
		time_symbol=$time_moon_symbol
	else
		time_symbol=$time_sun_symbol
	fi

	# zsh version
	echo -e "%F{$(date_col_parse)}${time_symbol}%f"

	# bash version
	# echo -e "$(tput setaf $(date_col_parse))${time_symbol} $(tput sgr0)"
}

print_time_symbol_full_dt()
{
	date_now=$(date +"%H")
	if [[ $date_now > 20 || $date_now < 5 ]]; then
		time_symbol=$time_moon_symbol
	else
		time_symbol=$time_sun_symbol
	fi

	# zsh version
	echo -e "%F{$(date_col_parse)}${time_symbol} (%D{%H:%M %d-%m})%f"
}



# >> Git

# >>> Use git provided script
source ~/.dotfiles/.git-prompt.sh

# >>> Set parameters for git script
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1
#colors only work if using PROMPT_COMMAND ??
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUPSTREAM="auto"


# >> Set colors for prompt (0-5 RGB colors)
_dirPromptC="$(RGBcolor 0 5 5)"
_gitPromptC="$(RGBcolor 3 0 3)"
_exitCodePromptC="$(RGBcolor 5 2 2)"

# >> Assemble the prompt

# for new line, use literal new line!
# To use a color: %F{colour} ... %f
# bold: %B ... %b
# Underline: %U ... %u
# Background color: %K ... %k

# PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '

PS1='
$(print_time_symbol_full_dt)
%B%F{$_gitPromptC}$(__git_ps1 "(%s)")%f%b%F{$_dirPromptC}(%~)%f
%(?..%K{$_exitCodePromptC}%F{black}%?%f%k )> '

# PS1="
# \$(print_time_symbol_full_dt)
# %B%F{$_gitPromptC}\$(__git_ps1 '(%s)')%f%b%F{$_dirPromptC}(%~)%f
# %(?..%K{$_exitCodePromptC}%F{black}%?%f%k )> "

# Line Editing vim mode

bindkey -v
# re-bind history search (unbound by vi mode)
bindkey ^R history-incremental-search-backward
bindkey ^S history-incremental-search-forward

# > History

export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=$HISTSIZE

# setopt APPEND_HISTORY
setopt SHARE_HISTORY             # Share history between all sessions.
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_NO_STORE             # don't store history or fc commands
