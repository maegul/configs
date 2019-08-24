# for using het conda installation
#VIRTUAL_ENV_DISABLE_PROMPT=1 source /Users/errollloyd/Library/Enthought/Canopy_64bit/User/bin/activate
export EDITOR=vim
export PATH="$(/Users/errollloyd/.dotfiles/custom_path.sh)"

# vi mode for bash
set -o vi
# bind escape to k+j
bind '"kj":"\e"'



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

# Checking if interactive, to prepare prompt only for interactive
# Using .bash_profile and .bashrc more appropriately may make this cleaner
if [[ $- == *i* ]]
then

# Edits prompt

#old
#export PS1="\n(\!)-(\[\e[37m\]\t\[\e[0m\])-(\[\e[31m\]\u\[\e[0m\])-(\[\e[36m\]\w\[\e[0m\])\n> "


# USing git-prompt (semi-official)

source ~/.dotfiles/.git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1
#colors only work if using PROMPT_COMMAND ??
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUPSTREAM="auto"

###
# prompt
###

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

# check if in conda env, if so return (env)
# used instead of default conda prompt change
# turned off with conda config --set changeps1 false
print_conda_env()
{
	if [ -n "$CONDA_DEFAULT_ENV" ]; then
		echo "($CONDA_DEFAULT_ENV)"
	fi
}

# For converting current time to col idx from file
source ~/.dotfiles/date_cols_test.sh
# unicode for a filled sun symbol

time_sun_symbol="\xe2\x98\x80"
time_moon_symbol="\xe2\x98\xbe"

print_time_symbol()
{
	date_now=$(date +"%H")
	if [[ $date_now > 20 && $date_now < 5 ]]; then
		time_symbol=$time_moon_symbol
	else
		time_symbol=$time_sun_symbol
	fi
	echo -e "$(tput setaf $(date_col_parse))${time_symbol} $(tput sgr0)"
}

# Converts RGB coords (6x6x6) to ASNI color code
function RGBcolor {                                               
    echo "16 + $1 * 36 + $2 * 6 + $3" | bc                        
} 

# Checking if interactive, for tput assignments


# Predefined colors
reset=$(tput sgr0)
bold=$(tput bold)
rev=$(tput rev)
# hist_numberBG=$(tput setab 33)
# hist_number=$(tput setaf 213)
col_BUTime=$(tput setaf 208)
gitPrompt=$(tput setaf $(RGBcolor 3 0 3) )
condaEnvCol=$(tput setaf $(RGBcolor 0 4 1))

# Converts time of day to col from 30 cols in ANSI_cols_by_hue


PS1="\n"
# PS1+="\$(echo -e '$(tput setaf $(date_col_parse))${time_sun_symbol}$(tput sgr0) ')"
PS1+="\$(print_time_symbol)"
PS1+="\[${bold}\]"
# PS1+="\[${rev}\]"
PS1+="\[${col_BUTime}\]\$(print_backup_check)"
PS1+="\[${condaEnvCol}\]\$(print_conda_env)"
PS1+="\n"
PS1+="\[${gitPrompt}\]\$(__git_ps1 '(%s)')"
PS1+="\[\e[36m\](\w)"
PS1+="\[\e[36;2m\]\$(print_dirs)"
PS1+="\[${reset}\]"
PS1+="\n> "

export PS1
# Adds script for git autocomplete
source ~/.dotfiles/.git-completion.bash


#Old custom git prompt
#parse_git_branch(){ git branch 2>/dev/null | grep '^*' | colrm 1 2;}

#export PS1="\n(\!)-(\[\e[31m\]\u\[\e[0m\])\n(\[\e[36m\]\w\[\e[0m\])-(\[\e[35m\]\$(parse_git_branch)\[\e[0m\])\n> "


fi


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
# CLICOLOR_FORCE for BSD/MAC to force ls to provide color chars in output to non terminal
# alias lls='CLICOLOR_FORCE= ll | less -R'

alias cl='clear'
alias bpe='vim ~/.bash_profile'



# python web server (py 2)
# alias py_serve='python -m SimpleHTTPServer'
# python 3 version
alias py_serve='python -m http.server'

# spartan SSH
alias spartan_ssh='ssh errol@spartan.hpc.unimelb.edu.au'

alias spartan_ssh_io='ssh errol@spartan-io.hpc.unimelb.edu.au'

# nectar errol-test ssh
alias nectar_test_ssh='ssh -i ~/.ssh/nectar_private_key ubuntu@115.146.92.170'

# mac pro ssh

alias mac_pro_ssh='ssh Errol@errol-mac-pro.mobility.unimelb.net.au'

alias mac_pro_hal_ssh='ssh Hal@errol-mac-pro.mobility.unimelb.net.au'

alias aryabhat_ssh='ssh Aryabhat@10.100.132.149'

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

alias goto_lenTun_data='cd /Volumes/MagellanX/PhD/Data/length_tun_data/'
alias goto_proj_notes='cd ~/Dropbox/Science/PhD/project_notes'

# alias for quick debug
alias qlldb='lldb --batch -o run -o bt -o q'

lls() {
	CLICOLOR_FORCE= ls -haltF $1 | less -R
}

## Current transitioning conda env to python 3 ... quickly source

# transition complete(?)
# alias pynew='source activate n3w'

# pandoc function to convert markdown to docx of same filename
md2doc() {
	file=$1
	pandoc $file -o "${file%.*}.docx"
}

# Clones and then forks a GitHub repo
# Relies on hub and ack for regex
fork_gh() {
	regex='([\w\d]+).git$'
	repo_dir="$(echo $1 | ack $regex --output '$1')"
	# echo $repo_dir
	git clone $1
	cd $repo_dir
	hub fork
}

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


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/errollloyd/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/errollloyd/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/errollloyd/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/errollloyd/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

