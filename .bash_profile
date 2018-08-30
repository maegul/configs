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

export PS1="\n(\!)-(\[\e[31m\]\u\[\e[0m\])(\[\e[38;5;208m\]\$(backup_since)\[\e[0m\])\n(\[\e[36m\]\w\[\e[0m\])\[\e[35m\]\$(__git_ps1 '(%s)')\[\e[36;2m\]\$(print_dirs)\[\e[0m\]\[\e[0m\]\n> "


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

# mac pro ssh

alias mac_pro_ssh='ssh Errol@errol-mac-pro.mobility.unimelb.net.au'


# matlab no desktop alias

alias matlab_cl='matlab -nodesktop -nodisplay -nosplash'


# get current ip address

alias my_ip='ipconfig getifaddr en0'



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

