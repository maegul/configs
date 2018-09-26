# for using het conda installation
#VIRTUAL_ENV_DISABLE_PROMPT=1 source /Users/errollloyd/Library/Enthought/Canopy_64bit/User/bin/activate
export EDITOR=vim
export PATH="$(/Users/errollloyd/.dotfiles/custom_path.sh)"

# added by Anaconda 1.8.0 installer
# export PATH="/Users/errollloyd/anaconda/bin:$PATH"

# export PATH=$PATH:~/abin

# export PATH=/Applications/NEURON-7.4/nrn/x86_64/bin:$PATH #added by NEURON installer

# export PATH="/usr/local/bin:$PATH"

# export PATH="$HOME/bin:$PATH"

# Adds my personal script library to pythonpath
export PYTHONPATH=${PYTHONPATH}:~/Dropbox/Science/scripts/

# For terminus in sublime text
bind '"\e[1;3C": forward-word' 
bind '"\e[1;3D": backward-word'


###
# Prompt
###


# Edits prompt

#old
#export PS1="\n(\!)-(\[\e[37m\]\t\[\e[0m\])-(\[\e[31m\]\u\[\e[0m\])-(\[\e[36m\]\w\[\e[0m\])\n> "


# USing git-prompt (semi-official)

source ~/.git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1
#colors only work if using PROMPT_COMMAND ??
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUPSTREAM="auto"

# prompt
# export PS1="\n(\!)-(\[\e[31m\]\u\[\e[0m\])\n(\[\e[36m\]\w\[\e[0m\])\[\e[35m\]\$(__git_ps1 '(%s)')\[\e[0m\]\n> "

# addings a pushd dirs to prompt when more than one in stack
print_dirs(){ 
	if (($(dirs -v | wc -l) > 1));
	then
		echo -e "\n$(dirs -v | tail -n +2)";
	fi	
}

print_backup_check()
{
	time_since=$(backup_since)
	if [[ $time_since > 1 ]]; then
		echo "(${time_since})"
	fi
}

# export PS1="\n(\[${hist_number}\]\[${hist_numberBG}\]\!\[${reset}\])-(\[\e[31m\]\u\[\e[0m\])(\[\e[38;5;208m\]\$(backup_since)\[\e[0m\])\n(\[\e[36m\]\w\[\e[0m\])\[\e[35m\]\$(__git_ps1 '(%s)')\[\e[36;2m\]\$(print_dirs)\[\e[0m\]\[\e[0m\]\n> "
# export PS1="\n(\[${hist_number}\]\[${hist_numberBG}\]\!\[${reset}\])-(\[\e[31m\]\u\[\e[0m\])(\[\e[38;5;208m\]\$(backup_since)\[\e[0m\])\n(\[\e[36m\]\w\[\e[0m\])\[\e[35m\]\$(__git_ps1 '(%s)')\[\e[36;2m\]\$(print_dirs)\[\e[0m\]\[\e[0m\]\n> "

# For converting current time to col idx from file
source ~/.dotfiles/date_cols_test.sh
# unicode for a filled sun symbol
time_sun_symbol="\xe2\x98\x80"

print_time_symbol()
{
	echo -e "$(tput setaf $(date_col_parse))${time_sun_symbol} $(tput sgr0)"
}

# Converts RGB coords (6x6x6) to ASNI color code
function RGBcolor {                                               
    echo "16 + $1 * 36 + $2 * 6 + $3" | bc                        
} 

# Predefined colors
reset=$(tput sgr0)
bold=$(tput bold)
rev=$(tput rev)
# hist_numberBG=$(tput setab 33)
# hist_number=$(tput setaf 213)
col_BUTime=$(tput setaf 208)
gitPrompt=$(tput setaf $(RGBcolor 3 0 3) )

# Converts time of day to col from 30 cols in ANSI_cols_by_hue


PS1="\n"
# PS1+="\$(echo -e '$(tput setaf $(date_col_parse))${time_sun_symbol}$(tput sgr0) ')"
PS1+="\$(print_time_symbol)"
PS1+="\[${bold}\]"
# PS1+="\[${rev}\]"
PS1+="\[${col_BUTime}\]\$(print_backup_check)"
PS1+="\[${gitPrompt}\]\$(__git_ps1 '(%s)')"
PS1+="\[\e[36m\](\w)"
PS1+="\[\e[36;2m\]\$(print_dirs)"
PS1+="\[${reset}\]"
PS1+="\n> "

export PS1
# Adds script for git autocomplete
source ~/git-completion.bash


#Old custom git prompt
#parse_git_branch(){ git branch 2>/dev/null | grep '^*' | colrm 1 2;}

#export PS1="\n(\!)-(\[\e[31m\]\u\[\e[0m\])\n(\[\e[36m\]\w\[\e[0m\])-(\[\e[35m\]\$(parse_git_branch)\[\e[0m\])\n> "


# Change terminal colors
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Add another directory to path, for MRI analysis software

# ??? --- Don't know what this is about, I didn't do it ...
export DYLD_FALLBACK_LIBRARY_PATH=$DYLD_FALLBACK_LIBRARY_PATH:~/abin


export PYTHONPATH=${PYTHONPATH}:/Applications/NEURON-7.4/nrn/lib/python #added by NEURON installer

# The line below appears unnecessary ... adding anaconda/bin to PATH is sufficient.
# Indeed, the below breaks pip's ability to be environment aware in conda environments
# export PYTHONHOME="/Users/errollloyd/anaconda" #added by NEURON installer

# not sure what this is about or why it's necessary ... my remove
export LD_LIBRARY_PATH="/Users/errollloyd/anaconda/lib:$LD_LIBRARY_PATH" #added by NEURON installer

# Add User executables to path early so that they override /usr/bin


### this directory should be used by HomeBrew.  It should also be added by path_helper through /etc/paths, but in the wrong order.  I don't want to muck around with /etc/paths, so Im adding it here.  It will probably appear twice in PATH now. :(

# Add personal executables in $HOME/bin to path


# NPM global installs available by require()
export NODE_PATH=/usr/local/lib/node_modules

# shell options

# extglob - more regex options (?)
shopt -s extglob

# history management
# allow preceding whitespace to prevent from being logged in history
HISTCONTROL=ignorespace

HISTSIZE=5000
HISTFILESIZE=20000

shopt -s histappend

# Some alias play ... yay!
alias ll='ls -haltF'

# git aliases
alias git_mylog="git log --pretty=format:'%C(yellow)%h %Cred%ad %Cblue%an%Cgreen%d %Creset%s' --date=short"

alias git_mylog_graph='git log --oneline --graph'

# python web server
alias py_serve='python -m SimpleHTTPServer'

# spartan SSH
alias spartan_ssh='ssh errol@spartan.hpc.unimelb.edu.au'

alias spartan_ssh_io='ssh errol@spartan-io.hpc.unimelb.edu.au'

# nectar errol-test ssh
alias nectar_test_ssh='ssh -i ~/.ssh/nectar_private_key ubuntu@115.146.92.170'

# mac pro ssh

alias mac_pro_ssh='ssh Errol@errol-mac-pro.mobility.unimelb.net.au'

alias mac_pro_hal_ssh='ssh Hal@errol-mac-pro.mobility.unimelb.net.au'


# matlab no desktop alias

alias matlab_cl='matlab -nodesktop -nodisplay -nosplash'


# get current ip address

alias my_ip='ipconfig getifaddr en0'


# tmux aliases

# create new named tmux session
alias tm_new="tmux new -s"

# list sessions
alias tm_ls="tmux ls"

# attach to named session
alias tm_at="tmux a -t"

# kill named session
alias tm_kill="tmux kill-session -t"

# Misc Aliases

# sublime text

## Go to User folder of current sublime text install
alias goto_sublime_user='cd ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User'



# for viewing man pages in vim
vman() {
	vim -c "SuperMan $*"

	if [ "$?" != "0" ]; then
		echo "No manual entry for $*"
	fi
}


# quick find in current directory
function myfind { find . -iname "$1" -print; }

# make and change to directory
mkcd()
{
	mkdir -- "$1" &&
		cd -- "$1"
}

# aliases for pushd stack usage
#alias pcd='pushd'
pcd_re='^[0-9]+$'
pcd()
{
	if [[ "$1" =~ $pcd_re ]] ; then
		pushd +"$1" > /dev/null
	else
		pushd "$1" > /dev/null
	fi   	
}
alias dirs='dirs -v'
mkpcd()
{
	mkdir -- "$1" &&
		pcd "$1"
}

# clear with dirs -c
pclear()
{
	dirs -c
}


# Open safari window and start jupyter notebook kernel 
######
# Requires the window to be refreshed
# Relies on an Apple Script to open a new window with a particular URL
# All of this is necessary just to keep the auto open tab behaviour of safari ... there's probably a better way
function jnb {

	for n in {0..20}
	do let nn=8888+n
		if lsof -Pi :$nn -sTCP:LISTEN -t >/dev/null; then
			echo "$nn already being used";
		else
			osascript ~/Library/Scripts/jnb_saf_open.scpt "http://localhost:$nn"
			jupyter notebook --port=$nn --no-browser
			break
		fi
	done

}

